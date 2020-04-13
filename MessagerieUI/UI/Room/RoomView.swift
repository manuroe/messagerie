//
//  RoomView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 11/08/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import SwiftUI

// TODO(MacOS)
//import KeyboardObserving


// Offset control
// https://zacwhite.com/2019/scrollview-content-offsets-swiftui/

struct RoomView: View {
    var viewModel: RoomViewModelType
    @ObservedObject var state: RoomViewState

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(state.items) { item in
                        RoomItemView(item: item)
                            .rotationEffect(.degrees(180))
                    }
                }
            }
            .rotationEffect(.degrees(180))
            .onAppear {
                self.viewModel.process(action: .load)
            }
            // To enable blur effect on top and bottom of screen
            // As a bonus, it puts the scrollbar to the normal RHS (?)
            .edgesIgnoringSafeArea(.all)

            
            MessageComposerView(onComposerAction: { action in
                self.onComposerAction(action: action)
            })
        }
        // TODO(MacOS)
        //.navigationBarTitle(Text(state.roomName), displayMode: .inline)
        //.keyboardObserving()
    }

    private func onComposerAction(action: MessageComposerAction) {
        viewModel.process(action: .messageComposerAction(action: action))
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
