//
//  RoomView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 11/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct RoomView: View {

    @ObservedObject var viewModel: RoomViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.items) { item in
                        HStack {
                            RoomItemView(item: item)
                            Spacer()
                        }
                    }
                }
            }
            .onAppear(
                perform: self.viewModel.start
            )
        }
        .navigationBarTitle(Text(viewModel.roomName), displayMode: .inline)
    }
}

//#if DEBUG
//struct RoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        //RoomView(viewModel: RoomViewModel.stub()) :/
//        Text("TODO: Where are my stubs?")
//    }
//}
//#endif
