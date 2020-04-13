//
//  LoginView.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 12/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import SwiftUI

struct LoginView: View {

    var viewModel: LoginViewModelType
    @ObservedObject var state: LoginViewState

    @State private var server = "" //: String? TODO
    @State private var userId = ""
    @State private var password  = ""

    var body: some View {
        NavigationView {
            Group {
                Form {
                    if state.serverSection?.displayIt == true {
                        Section(header: Text(state.serverSection!.serverHeaderTitle)) {
                            TextField(state.serverSection!.defaultServer, text: $server)
                        }
                    }

                    Section(header: Text("Credentials")) {
                        TextField("user id", text: $userId)
                        SecureField("password", text: $password)
                    }

                    Section {
                        HStack() {
                            Spacer()
                            Button(action: {
                                self.viewModel.process(viewAction: .login(server: self.server, userId: self.userId, password: self.password))
                            }) {
                                Text(state.logingIn ? "Signing..." : "Sign In")
                                }
                            .disabled(isFormDataInValid())
                            Spacer()
                        }
                    }
                }.disabled(state.logingIn)
            }
            // TODO(MacOS)
            //.navigationBarTitle("Sign In", displayMode: .large)
            .onAppear(perform: didLoad)
        }
    }

    private func didLoad() {
        guard let serverSection = state.serverSection else {
            return
        }
        server = serverSection.defaultServer
    }

    private func isFormDataInValid() -> Bool {
        server.count == 0
        || userId.count == 0
        || password.count == 0
    }
}


extension LoginView: Identifiable {
    var id: String {
        "LoginView"
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Text("TODO")
    }
}
