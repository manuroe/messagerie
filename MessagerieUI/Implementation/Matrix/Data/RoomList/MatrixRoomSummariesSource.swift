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

class MatrixRoomSummariesSource: RoomSummariesSource {

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

    func load() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.mxSessionStateDidChange, object: mxSession, queue: nil) { (_) in
            self.update()
        }

        if (mxSession.state.rawValue >= MXSessionStateStoreDataReady.rawValue) {
            update()
        }
    }

    func update() {
        let roomsSummaries = mxSession.roomsSummaries() as [MXRoomSummary]

        let rooms = roomsSummaries.map({ return self.buildRoom(from: $0) })
        subject.send(rooms)
    }

    private func buildRoom(from roomSummary: MXRoomSummary) -> RoomSummary {
        let size = CGSize(width: 40, height: 40) // TODO: Must be driven by the UI
        return RoomSummary(roomId: roomSummary.roomId,
                           displayname: roomSummary.displayname ?? roomSummary.roomId,
                           avatar: session.urlString(mxcString: roomSummary.avatar, size: size) ?? "https://matrix.org/matrix.png")
    }
}
