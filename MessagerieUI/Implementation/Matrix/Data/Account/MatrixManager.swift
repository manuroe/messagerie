//
//  MatrixManager.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 03/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

class MatrixManager: ProtocolManager {

    private let sessionMananager = MatrixSessionManager.shared

    func makeRoomSummariesSource(account: Account) -> RoomSummariesSource {
        let session = matrixSession(forAccount: account)
        return MatrixRoomSummariesSource(session: session)
    }

    func makeUserSource(account: Account, userId: String) -> UserSource {
        let session = matrixSession(forAccount: account)
        return MatrixUserSource(session: session, userId: userId)
    }


    private func matrixSession(forAccount account: Account) -> MatrixSession{
        // Die in case of error
        let matrixAccount: MatrixAccount = account as! MatrixAccount
        return sessionMananager.session(account: matrixAccount)!
    }


}
