//
//  AccountMananger.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 01/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

class AccountManager {

    static let shared = AccountManager()

    var accounts: [AccountType] = []


    init() {
    }

    func addAccount(account: AccountType) {
        accounts.append(account)
    }

    // TODO: to move: Service Locator?
    var protocolDataFactories: [String: ProtocolDataFactoryType] = [:]
    func registerProtocolDataFactory(protocolName: String, factory: ProtocolDataFactoryType) {
        protocolDataFactories[protocolName] = factory
    }

    func protocolDataFactory(for protocolName: String) -> ProtocolDataFactoryType? {
         protocolDataFactories[protocolName]
    }
}
