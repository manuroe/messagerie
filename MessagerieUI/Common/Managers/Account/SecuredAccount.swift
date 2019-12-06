//
//  SecuredAccount.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 22/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation

import Locksmith

struct SecuredAccount: ReadableSecureStorable,
                    CreateableSecureStorable,
                    DeleteableSecureStorable,
                    GenericPasswordSecureStorable {
    let messagerieAccount: AccountType & Codable

    var service: String {
        messagerieAccount.protocolName
    }
    var account: String {
        messagerieAccount.userId
    }

    var data: [String : Any] {
        messagerieAccount.dictionary ?? [:]
    }
}
