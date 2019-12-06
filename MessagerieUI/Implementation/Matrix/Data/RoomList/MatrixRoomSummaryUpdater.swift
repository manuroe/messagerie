//
//  MatrixRoomSummaryUpdater.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 30/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation

import SwiftMatrixSDK

class MatrixRoomSummaryUpdater: MXRoomSummaryUpdater {

    private let session: MatrixSession
    private let onRoomSummaryUpdate: ((String) -> Void)

    lazy private var encooder = JSONEncoder()

    // TODO: injection
    private lazy var messageFactory = MatrixMessageFactory(session: session)

    internal init(session: MatrixSession, onRoomSummaryUpdate: @escaping ((String) -> Void)) {
        self.session = session
        self.onRoomSummaryUpdate = onRoomSummaryUpdate
    }

    @objc override func session(_ session: MXSession!, update summary: MXRoomSummary!, withLast event: MXEvent!, eventState: MXRoomState!, roomState: MXRoomState!) -> Bool {

        // TODO: Be less restrictive
        if event.type != MXEventType.roomMessage.identifier {
            return false
        }

        let result = super.session(session, update: summary, withLast: event, eventState: eventState, roomState: roomState)

        if result {
            if let lastMessage = messageFactory.buildMessage(from: event,
                                                          roomState: roomState,
                                                          direction: MXTimelineDirection.forwards) {
                summary.mss_lastMessage = lastMessage
                onRoomSummaryUpdate(summary.roomId)
            }
        }

        return result
    }
    
}
