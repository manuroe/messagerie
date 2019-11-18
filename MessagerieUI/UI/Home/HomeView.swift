//
//  HomeView.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 11/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var viewModel: HomeViewModel
    @ObservedObject var state: HomeViewState

    var body: some View {
        SwiftUIPagerView(index: $state.index, pages: views)
    }

    private var views: [AnyView] {
        var roomListViews = state.roomListViewModels.map { (roomListViewModel) -> AnyView in
            AnyView (
                RoomListView(viewModel: roomListViewModel)
            )
        }

        roomListViews.append(AnyView(self.matrixLoginView))

        return roomListViews
    }

    private var matrixLoginView: LoginView {
        let loginViewModel = MatrixLoginViewModel {account in
            self.onNewAccount(newAccount: account)
        }
        return LoginView(viewModel: loginViewModel, state: loginViewModel.state)
    }

    private func onNewAccount(newAccount: AccountType) {
        viewModel.process(viewAction: .addAccount(account: newAccount))
    }
}
