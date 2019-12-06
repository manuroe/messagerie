//
//  HomeView.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 11/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var viewModel: HomeViewModel
    @ObservedObject var state: HomeViewState

    var body: some View {
        SwiftUIPagerView(index: $state.index, pages: views)
    }

    private var views: [AnyIdentifiableView] {
        var roomListViews = state.roomListViewModels.map { (roomListViewModel) -> AnyIdentifiableView in
            AnyIdentifiableView(item: RoomListView(viewModel: roomListViewModel, state: roomListViewModel.state))
        }

        roomListViews.append(AnyIdentifiableView(item: self.makeMatrixLoginView()))

        return roomListViews
    }

    private func makeMatrixLoginView() -> LoginView {
        let loginViewModel = MatrixLoginViewModel {account in
            self.onNewAccount(newAccount: account)
        }
        return LoginView(viewModel: loginViewModel, state: loginViewModel.state)
    }

    private func onNewAccount(newAccount: AccountType) {
        viewModel.process(viewAction: .addAccount(account: newAccount))
    }
}
