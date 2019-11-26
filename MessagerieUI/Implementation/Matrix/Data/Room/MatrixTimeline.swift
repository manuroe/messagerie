//
//  MatrixRoomMessagesSource.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 06/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation
import Combine

import SwiftMatrixSDK

class MatrixTimeline: MessagesSourceType {

    private let subject = PassthroughSubject<MessagesUpdate, Never>()
    var publisher : AnyPublisher<MessagesUpdate, Never> {
        return subject.eraseToAnyPublisher()
    }

    private let session: MatrixSession
    private let mxSession: MXSession
    private let roomId: String

    private var timeline: MXEventTimeline?

    // TODO: injection
    private lazy var messageFactory = MatrixMessageFactory(session: session)

    private lazy var processingQueue: DispatchQueue = {
        DispatchQueue(label: "messagerie.MatrixTimeline.\(roomId)")
       }()


    init(session: MatrixSession, roomId: String) {
        self.session = session
        self.roomId = roomId
        mxSession = session.session
    }

    func paginate(messagesCount: UInt, direction: Direction) {
        self.getLiveTimeline { timeline in
            timeline.paginate(messagesCount,
                              direction: direction == .backwards ? .backwards : .forwards,
                              onlyFromStore: false) { _ in }
        }
    }

    private var dataReadyFuture: AnyCancellable?
    private func getLiveTimeline(completion: @escaping (_ timeline: MXEventTimeline) -> Void) {
        if let timeline = self.timeline {
            completion(timeline)
            return
        }

        dataReadyFuture = session.dataReadyFuture().sink(receiveValue: { state in
            self.dataReadyFuture = nil      // boring

            guard let mxRoom = self.mxSession.room(withRoomId: self.roomId) else {
                return
            }

            mxRoom.liveTimeline() { timeline in
                 guard let timeline = timeline else {
                     return
                 }

                 self.setup(timeline: timeline)
                 self.timeline = timeline
                 completion(timeline)
             }
        })
    }

    private func setup(timeline: MXEventTimeline) {

        timeline.resetPagination()
        self.setupEventListener(for: timeline)
    }

    private func setupEventListener(for timeline: MXEventTimeline) {
        _ = timeline.listenToEvents { (event, direction, roomState) in
            self.onMatrixEvent(event, roomState: roomState, direction: direction)
        }
    }

    private func onMatrixEvent(_ event: MXEvent, roomState: MXRoomState, direction: MXTimelineDirection) {
        // TODO: Bufferise updates
        // TODO: Manage other cases (deletion, update)
        // TODO: Combine that
        processingQueue.async {
            if let message = self.messageFactory.buildMessage(from: event, roomState: roomState, direction: direction) {
                DispatchQueue.main.async {
                    if direction == .backwards {
                        self.subject.send(.backwards(messages: [message]))
                    } else {
                        self.subject.send(.forwards(messages: [message]))
                    }
                }
            }
        }
    }
    
}
