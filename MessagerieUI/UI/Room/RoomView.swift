//
//  RoomView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 11/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

import KeyboardObserving

struct RoomView: View {
    var viewModel: RoomViewModelType
    @ObservedObject var state: RoomViewState

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(state.items) { item in
                        HStack {
                            RoomItemView(item: item)
                            Spacer()
                        }
                        .rotationEffect(.degrees(180))
                    }
                }
            }
            .rotationEffect(.degrees(180))
            .onAppear {
                self.viewModel.process(action: .load)
            }

            MessageComposerView(onComposerAction: { action in
                self.onComposerAction(action: action)
            })
        }
        .navigationBarTitle(Text(state.roomName), displayMode: .inline)
        .keyboardObserving()
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
