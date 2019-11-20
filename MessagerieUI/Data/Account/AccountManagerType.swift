//
//  AccountManagerType.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 20/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

protocol AccountManagerType {
    func getAccounts() -> [AccountType]
    func addAccount(account: AccountType)
}
