//
//  MatrixAccountManager.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 01/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

class MatrixSessionManager {

    static let shared = MatrixSessionManager()

    private var sessions: [String: MatrixSession]

    init() {
        sessions = [:]
    }
    
    func session(account: MatrixAccount) -> MatrixSession? {
        if let session = sessions[account.userId] {
            return session
        }

        let session = MatrixSession(account: account)
        sessions[account.userId] = session
        return session
    }
}
