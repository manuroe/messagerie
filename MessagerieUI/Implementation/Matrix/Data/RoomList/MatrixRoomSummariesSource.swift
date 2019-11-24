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

    init(session: MatrixSession) {
        self.session = session
        mxSession = session.session
    }

    private var dataReadyFuture: AnyCancellable?
    func load() {
        dataReadyFuture = session.dataReadyFuture().sink(receiveValue: { state in
            self.dataReadyFuture = nil      // boring

            self.update()

            self.setupListener()
        })
    }

    func update() {
        let roomsSummaries = mxSession.roomsSummaries() as [MXRoomSummary]

        let rooms = roomsSummaries.map({ return self.makeRoom(from: $0) })
        subject.send(rooms)
    }


    private func setupListener() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.mxRoomSummaryDidChange, object: nil, queue: nil) { notification in
            guard let roomSummary = notification.object as? MXRoomSummary else {
                return
            }

            if roomSummary.mxSession.myUser.userId == self.mxSession.myUser.userId {
                self.update()
            }
        }
    }

    private func makeRoom(from roomSummary: MXRoomSummary) -> RoomSummary {
        let size = CGSize(width: 40, height: 40) // TODO: Must be driven by the UI
        
        return RoomSummary(roomId: roomSummary.roomId,
                           displayname: roomSummary.displayname ?? roomSummary.roomId,
                           avatar: session.urlString(mxcString: roomSummary.avatar, size: size) ?? "https://matrix.org/matrix.png",
                           lastMessageTs: roomSummary.lastMessageOriginServerTs)
    }
}
