//
//  MessageComposerView.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 25/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct MessageComposerView: View {
    var onComposerAction: (_ action: MessageComposerAction) -> Void

    @State var textMessage: String = ""

    var body: some View {
        HStack {

            TextField("Send a message...",
                      text: $textMessage,
                      onCommit: onTextMessageCommit)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(minHeight: 40)
            .padding(.leading)


//            Button(action: {
//                // TODO
//            }) {
//                   Image(systemName: "plus")
//               }

            Button(action: {
                self.onTextMessageCommit()
            }, label: {
                Image(systemName: "paperplane.fill")
            })
            .padding(.trailing)
            .disabled(textMessage.isEmpty)
        }
    }

    func onTextMessageCommit() -> Void {
        onComposerAction(.textMessage(message: textMessage))
        textMessage = ""
    }
}


struct MessageComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Text("TODO")
    }
}
