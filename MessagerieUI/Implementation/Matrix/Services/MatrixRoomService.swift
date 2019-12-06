//
//  MatrixRoomService.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 25/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation
import Combine

import SwiftMatrixSDK

class MatrixRoomService: RoomServiceType {
    private let session: MatrixSession
    private let mxSession: MXSession
    private let roomId: String

    private let room: MXRoom


    init(session: MatrixSession, roomId: String) {
        self.session = session
        self.roomId = roomId
        mxSession = session.session

        room = mxSession.room(withRoomId: roomId)!  // TODO: Bof
    }

    func send(message: String) -> AnyPublisher<String, Error> {
        Future<String, Error> { promise in
            var localEchoEvent: MXEvent?
            self.room.sendTextMessage(message, localEcho: &localEchoEvent) { response in
                switch response {
                case .failure(let error):
                    promise(.failure(error))
                case .success(let eventId):
                    promise(.success(eventId!))
                }
            }
        }.eraseToAnyPublisher()
    }

}
