//
//  MatrixManager.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 03/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

class MatrixDataFactory: ProtocolDataFactoryType {

    private let sessionMananager = MatrixSessionManager.shared

    func makeRoomSummariesSource(account: AccountType) -> RoomSummariesSourceType {
        let session = matrixSession(forAccount: account)
        return MatrixRoomSummariesSource(session: session)
    }

    func makeTimeline(account: AccountType, roomId: String) -> MessagesSourceType {
        let session = matrixSession(forAccount: account)
        return MatrixTimeline(session: session, roomId: roomId)
    }

    func makeUserSource(account: AccountType, userId: String) -> UserSourceType {
        let session = matrixSession(forAccount: account)
        return MatrixUserSource(session: session, userId: userId)
    }


    private func matrixSession(forAccount account: AccountType) -> MatrixSession{
        // Die in case of error
        let matrixAccount: MatrixAccount = account as! MatrixAccount
        return sessionMananager.session(account: matrixAccount)!
    }


}
