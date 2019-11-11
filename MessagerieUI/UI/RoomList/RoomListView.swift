//
//  RoomListView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 14/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct RoomListView: View {

    @ObservedObject var viewModel: RoomListViewModel

    var body: some View {

        NavigationView {
            VStack {
                Group {
                    if viewModel.rooms != nil {
                        List(viewModel.rooms!) { room in
                            NavigationLink(destination: self.roomView(for: room.roomId)) {
                                HStack {
                                    AvatarView(avatarUrl: room.avatar, width: 40, height: 40)
                                    Text(room.displayname)
                                }
                            }
                        }
                    }
                    else {
                        Text("Loading...")
                    }
                }
            }
            .navigationBarTitle(
                Text((viewModel.myUser != nil) ? viewModel.myUser!.displayname : "")
            )
            .navigationBarItems(
                leading: AvatarView(avatarUrl: viewModel.myUser?.avatar, width: 30, height: 30)
            )
        }
    }

    func roomView(for roomId: String) -> RoomView {

        let accountManager = AccountManager.shared
        let account = viewModel.account
        let protocolManager = accountManager.manager(protocolType: account.protocolName)!

        let messagesSource = protocolManager.makeTimeline(account: account, roomId: roomId)
        let roomViewModel = RoomViewModel(source: messagesSource)

        return RoomView(viewModel: roomViewModel)
    }
}


#if DEBUG
struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
//        let viewModel = RoomListViewModel(source: MockRoomSummariesSource(), userSource: MockUserSource())
//        return RoomListView(viewModel: viewModel)
        Text("TODO")
    }
}
#endif
