//
//  File.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 01/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

struct MatrixAccount: AccountType {
    let protocolName = ProtocolName.matrix
    
    let homeserver: URL
    let userId: String
    //let deviceId: String
    let accessToken: String
}

extension MatrixAccount: Codable {
}


extension ProtocolName {
    static let matrix = "matrix.org";
}
