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

class MatrixTimeline: MessagesSource {

    private let subject = PassthroughSubject<MessagesUpdate, Never>()
    var publisher : AnyPublisher<MessagesUpdate, Never> {
        return subject.eraseToAnyPublisher()
    }

    private let session: MatrixSession
    private let mxSession: MXSession
    private let roomId: String

    private let mxRoom: MXRoom
    private var timeline: MXEventTimeline?

    // TODO: injection
    private lazy var messageFactory = MatrixMessageFactory()

    init(session: MatrixSession, roomId: String) {
        self.session = session
        self.roomId = roomId
        mxSession = session.session

        // TODO: This can fail
        mxRoom = mxSession.room(withRoomId: roomId)
    }

    func paginate(messagesCount: UInt, direction: Direction) {
        self.getLiveTimeline { timeline in
            
            timeline.paginate(messagesCount,
                              direction: direction == .backwards ? .backwards : .forwards,
                              onlyFromStore: false) { _ in }
        }
    }

    private func getLiveTimeline(completion: @escaping (_ timeline: MXEventTimeline) -> Void) {
        if let timeline = self.timeline {
            completion(timeline)
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
        if let message = self.messageFactory.buildMessage(from: event, roomState: roomState, direction: direction) {
            // TODO: Bufferise updates
            // TODO: Manage other cases (deletion, update)
            if direction == .backwards {
                self.subject.send(.backwards(messages: [message]))
            } else {
                self.subject.send(.forwards(messages: [message]))
            }
        }
    }
}