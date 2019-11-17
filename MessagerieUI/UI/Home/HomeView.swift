//
//  HomeView.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 11/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State var index: Int = 0
    
    var views: [AnyView] {
        var roomListViews = viewModel.roomListViewModels.map { (roomListViewModel) -> AnyView in
            AnyView (
                RoomListView(viewModel: roomListViewModel)
            )
        }

        roomListViews.append(AnyView(self.matrixLoginView))

        return roomListViews
    }

    var body: some View {
        SwiftUIPagerView(index: $index, pages: views)
    }

    private var matrixLoginView: LoginView {
        let loginViewModel = MatrixLoginViewModel {account in
            self.onNewAccount(newAccount: account)
        }
        return LoginView(viewModel: loginViewModel, state: loginViewModel.state)
    }

    private func onNewAccount(newAccount: AccountType) {
        // TODO
    }
}
