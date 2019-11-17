//
//  MatrixLoginViewModel.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 17/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

class MatrixLoginViewModel : LoginViewModelType {
    let state: LoginViewState
    var onNewAccount: (AccountType) -> Void

    func process(viewAction: LoginViewAction) {
        switch viewAction {
        case .login(server: let homeserver, userId: let userId, password: let password):
            guard let homeserver = homeserver else {
                return
            }
            processLogin(homeserver: homeserver, userId: userId, password: password)
        }
    }

    private func processLogin(homeserver: String, userId: String, password: String) {
        if state.logingIn == true {
            return
        }

        state.logingIn = true
        // TODO
    }



    struct Constant {
        static let defaultHomeserver = "https://matrix.org"
    }

    init(onNewAccount: @escaping (AccountType) -> Void) {
        self.onNewAccount = onNewAccount

        state = LoginViewState(serverSection:
            LoginViewState.ServerSection(
                displayIt: true,
                defaultServer: Constant.defaultHomeserver,
                serverHeaderTitle: "Matrix homeserver"
            )
        )
    }
}
