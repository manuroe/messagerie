//
//  HomeView.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 11/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct HomeView<Content: View & Identifiable>: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State var index: Int = 0
    
    var views: [Content] {
        viewModel.roomListViewModels.map { (roomListViewModel) -> Content in
            RoomListView(viewModel: roomListViewModel) as! Content
        }
    }

    var body: some View {
        SwiftUIPagerView(index: $index, pages: views)
    }
}
