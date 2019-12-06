//
//  ProtocolDataFactoryManager.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 11/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation

// TODO: Kind of Service Locator. No?
class ProtocolDataFactoryManager {

    static let shared = ProtocolDataFactoryManager()

    var protocolDataFactories: [String: ProtocolDataFactoryType] = [:]
    
    func registerFactory(protocolName: String, factory: ProtocolDataFactoryType) {
        protocolDataFactories[protocolName] = factory
    }

    func factory(for protocolName: String) -> ProtocolDataFactoryType? {
         protocolDataFactories[protocolName]
    }
}
