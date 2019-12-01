//
//  RoomListView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 14/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct RoomListView: View {
    var viewModel: RoomListViewModelType
    @ObservedObject var state: RoomListViewState

    let roomViewsCache = RoomViewsCache()

    var body: some View {

        NavigationView {
            VStack {
                Group {
                    if state.rooms != nil {
                        List(state.rooms!) { summary in
                            NavigationLink(destination: self.roomView(for: summary)) {
                                RoomSummaryView(summary: summary)
                            }
                        }
                    }
                    else {
                        Text("Loading...")
                    }
                }
            }
            .onAppear {
                self.viewModel.process(action: .load)
            }
            .navigationBarTitle(
                Text((state.myUser != nil) ? state.myUser!.displayname : ""),
                displayMode: .inline
            )
            .navigationBarItems(
                leading: AvatarView(avatar: state.myUser?.avatar, width: 30, height: 30)
            )
        }
    }

    func roomView(for room: RoomSummary) -> RoomView {
        if let roomView = roomViewsCache.roomViews[room.roomId] {
            return roomView
        }

        let factoryManager = ProtocolDataFactoryManager.shared
        let account = state.account
        let dataFactory = factoryManager.factory(for: account.protocolName)!

        let messagesSource = dataFactory.makeTimeline(account: account, roomId: room.roomId)
        let roomService = dataFactory.makeRoomService(account: account, roomId: room.roomId)
        let roomViewModel = RoomViewModel(source: messagesSource, roomService: roomService,
                                          roomName: room.displayname, roomAvatar: room.avatar)

        let roomView = RoomView(viewModel: roomViewModel, state: roomViewModel.state)
        roomViewsCache.roomViews[room.roomId] = roomView
        return roomView
    }

    class RoomViewsCache {
        var roomViews: [String: RoomView] = [:]
    }
}


extension RoomListView: Identifiable {
    var id: String {
        state.account.protocolName + state.account.userId
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
