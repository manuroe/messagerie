//
//  MatrixRoomSummariesSource.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 03/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation
import Combine

import SwiftMatrixSDK

class MatrixRoomSummariesSource: RoomSummariesSourceType {

    private let subject = PassthroughSubject<[RoomSummary], Never>()
    var publisher : AnyPublisher<[RoomSummary], Never> {
        return subject.eraseToAnyPublisher()
    }

    private let session: MatrixSession
    private let mxSession: MXSession

    private lazy var processingQueue: DispatchQueue = {
        DispatchQueue(label: "messagerie.MatrixRoomSummariesSource")
       }()

 
    init(session: MatrixSession) {
        self.session = session
        mxSession = session.session

        setupRoomSummaryUpdater()
    }

    private var dataReadyFuture: AnyCancellable?
    func load() {
        dataReadyFuture = session.dataReadyFuture().sink(receiveValue: { state in
            self.dataReadyFuture = nil      // boring

            self.update()

            self.setupRoomSummaryUpdater()
        })
    }

    func setupRoomSummaryUpdater() {
        mxSession.roomSummaryUpdateDelegate = MatrixRoomSummaryUpdater(session: session, onRoomSummaryUpdate: { (roomId) in
            self.update()
        })
    }

    func update() {
        let roomsSummaries = mxSession.roomsSummaries() as [MXRoomSummary]

        // TODO: Combine that
        processingQueue.async {
            let rooms = roomsSummaries.map({ return self.makeRoom(from: $0) })
            DispatchQueue.main.async {
                self.subject.send(rooms)
            }
        }
    }

    private func makeRoom(from roomSummary: MXRoomSummary) -> RoomSummary {
        let size = CGSize(width: 56, height: 56) // TODO: Must be driven by the UI

        return RoomSummary(roomId: roomSummary.roomId,
                           displayname: roomSummary.displayname ?? roomSummary.roomId,
                           avatar: session.urlString(mxcString: roomSummary.avatar, size: size) ?? "https://matrix.org/matrix.png",
                           lastMessageTs: roomSummary.lastMessageOriginServerTs,
                           lastMessage: roomSummary.mss_lastMessage)
    }
}
