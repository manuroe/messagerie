//
//  SecureAccountManager.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 20/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

import Locksmith


class SecureAccountManager: AccountManagerType {

    func getAccounts() -> [AccountType] {
        return getAllKeyChainAccountServicePair().compactMap { (account, service) in
            guard let dictionary = Locksmith.loadDataForUserAccount(userAccount: account, inService: service) else {
                return nil
            }

            do {
                // TODO: Remove this dependency
                if service == ProtocolName.matrix {
                    return try MatrixAccount(from: dictionary)
                }
            } catch {
                print("[SecureAccountManager] getAccounts failed. Error: \(error)")
            }
            return nil
        }
    }

    func addAccount(account: AccountType) {
        let securedAccount = SecuredAccount(messagerieAccount: account)

        do {
            try securedAccount.createInSecureStore()
        } catch {
            print("[SecureAccountManager] addAccount failed. Error: \(error)")
        }
    }

    func udpateAccount(account: AccountType) {
        let securedAccount = SecuredAccount(messagerieAccount: account)

        do {
            try securedAccount.updateInSecureStore()
        } catch {
            print("[SecureAccountManager] udpateAccount failed. Error: \(error)")
        }
    }

    func removeAccount(protocolName: String, userId: String) {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: userId, inService: protocolName)
        } catch {
            print("[SecureAccountManager] removeAccount failed. Error: \(error)")
        }
    }
}


extension SecureAccountManager {
    // https://stackoverflow.com/a/48895792
    private func getAllKeyChainAccountServicePair(_ secClass: String = kSecClassGenericPassword as String) -> [(account: String, service: String)] {

        let query: [String: Any] = [
            kSecClass as String: secClass,
            kSecReturnData as String  : true,
            kSecReturnAttributes as String : true,
            kSecReturnRef as String : true,
            kSecMatchLimit as String: kSecMatchLimitAll
        ]

        var result: AnyObject?

        let lastResultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        var values = [(account: String, service: String)]()
        if lastResultCode == noErr {
            let array = result as? Array<Dictionary<String, Any>>

            for item in array! {
                if let account = item[kSecAttrAccount as String] as? String,
                    let service = item[kSecAttrService as String] as? String {
                    values.append((account: account,
                                   service: service))
                }
            }
        }

        return values
    }
    
}
