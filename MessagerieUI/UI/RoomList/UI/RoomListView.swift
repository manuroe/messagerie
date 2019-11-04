//
//  RoomListView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 14/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct RoomListView: View {

    //@ObservedObject var account: AccountViewModel   ?
    @ObservedObject var viewModel: RoomListViewModel

    var body: some View {

        NavigationView {
            VStack {
                Group {
                    if viewModel.rooms != nil {
                        List(viewModel.rooms!) { room in

    //                    NavigationLink(destination: RoomView(
    //                        //viewModel: RoomViewModel.stub())
    //                        viewModel: RoomViewModel(roomSummary: roomSummary)
    ///*
    //                        viewModel: RoomViewModel(timeline: timeline, roomService: roomService),
    //                        messageComposer: messageComposer(roomService)
    // */
    //                    )) {
                            HStack {
                                AvatarView(avatarUrl: room.avatar)
                                Text(room.displayname)
                            }
    //                    }

                }
                    }
                    else {
                        Text("Loading...")
                    }
                }
            }
            .navigationBarTitle(
                Text("TODO")
                //Text(account.session.myUser?.displayname ?? "Loading...")
            )
            .navigationBarItems(
                leading: NavLogo()
            )
        }
    }
}

// TODO
struct NavLogo: View {

    var body: some View {
//            VStack {
//                Image(systemName: "person")
//                    .resizable()
//                    .aspectRatio(2, contentMode: .fit)
//                    .imageScale(.large)
//            }
//            .frame(width: 200)
//            .background(Color.clear)

        Image(systemName: "person")


//        AvatarView(avatarUrl: "https://matrix.org/matrix.png")
    }
}

#if DEBUG
struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RoomListViewModel(source: MockRoomListSource())
        return RoomListView(viewModel: viewModel)
    }
}
#endif
