//
//  LoginViewState.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 17/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation

class LoginViewState: ObservableObject {

    @Published var logingIn: Bool = false
    @Published var error: Error?

    struct ServerSection {
        let displayIt: Bool
        let defaultServer: String
        let serverHeaderTitle: String
    }
    let serverSection: ServerSection?

    init(serverSection: ServerSection? = nil) {
        self.serverSection = serverSection
    }
}
