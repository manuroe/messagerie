//
//  AccountManagerType.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 20/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation

protocol AccountManagerType {
    func getAccounts() -> [AccountType]
    func addAccount(account: AccountType)
    func udpateAccount(account: AccountType)
    func removeAccount(protocolName: String, userId: String)
}
