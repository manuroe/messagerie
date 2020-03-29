//
//  MessageComposerView.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 25/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import SwiftUI

struct MessageComposerView: View {
    var onComposerAction: (_ action: MessageComposerAction) -> Void

    @State var textMessage: String = ""

    var body: some View {
        HStack {
            TextField("Text Message",
                      text: $textMessage,
                      onCommit: onTextMessageCommit)
                .offset(x: 8)

            Button(action: {
                self.onTextMessageCommit()
            }, label: {
                Image(systemName: "arrow.up.circle.fill")
                .resizable()
                .frame(width: 27.0, height: 27.0)
                .foregroundColor(.green)
            })
            .disabled(textMessage.isEmpty)
        }
        .padding(3)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.secondary)
        )
        .padding(.vertical, 2.0)
        .padding(.horizontal, 8.0)
        // Blur effect behind the composer
        .background(
            VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
                .edgesIgnoringSafeArea(.bottom)
        )
    }

    func onTextMessageCommit() -> Void {
        onComposerAction(.textMessage(message: textMessage))
        textMessage = ""
    }
}


// https://stackoverflow.com/a/59111492
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}


struct MessageComposerView_Previews: PreviewProvider {
    static var previews: some View {
        MessageComposerView(onComposerAction: { action in
        })
    }
}
