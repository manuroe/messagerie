//
//  MatrixLoginViewModel.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 17/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

import SwiftMatrixSDK

class MatrixLoginViewModel : LoginViewModelType {
    let state: LoginViewState
    var onNewAccount: (AccountType) -> Void

    private var matrixRestClient: MXRestClient?

    func process(viewAction: LoginViewAction) {
        switch viewAction {
        case .login(server: let homeserver, userId: let userId, password: let password):
            guard let homeserver = homeserver else {
                return
            }
            processLogin(homeserver: homeserver, userId: userId, password: password)
        case .cancel:
            cancel()
        }
    }

    private func processLogin(homeserver: String, userId: String, password: String) {
        guard let homeserverUrl = URL(string: homeserver), state.logingIn == false else {
            return
        }

        state.logingIn = true

        matrixRestClient = MXRestClient(homeServer: homeserverUrl, unrecognizedCertificateHandler: nil)
        matrixRestClient?.login(username: userId, password: password, completion: { response in
            switch response {
            case .success(let credentials):
                self.onNewCredentials(credentials: credentials)
            case .failure(let error):
                self.state.error = error
            }
        })
    }

    private func cancel() {
        guard let matrixRestClient = matrixRestClient else {
            return
        }

        matrixRestClient.close()
        self.matrixRestClient = nil
    }

    private func onNewCredentials(credentials: MXCredentials) {
        guard let account = makeMatrixAccount(from: credentials) else {
            return
        }
        onNewAccount(account)
    }

    private func makeMatrixAccount(from credentials: MXCredentials) -> MatrixAccount? {
        guard let homeserver = credentials.homeServer, let homeserverUrl = URL(string: homeserver),
            let userId = credentials.userId, let accessToken = credentials.accessToken else {
            return nil
        }

        return MatrixAccount(homeserver: homeserverUrl, userId: userId, accessToken: accessToken)
    }


    enum Constant {
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
