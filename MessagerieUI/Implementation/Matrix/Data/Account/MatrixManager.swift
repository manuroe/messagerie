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

    func roomListSource(account: Account) -> RoomSummariesSource {
        guard let matrixAccount: MatrixAccount = account as? MatrixAccount,
            let session = sessionMananager.session(account: matrixAccount) else {
            // Hmm
            return MockRoomSummariesSource()
        }

        return MatrixRoomSummariesSource(session: session)
    }

}
