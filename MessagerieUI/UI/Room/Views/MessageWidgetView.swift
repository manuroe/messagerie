//
//  MessageWidgetView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 24/10/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import SwiftUI
import WebKit


struct MessageWidgetWKWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}

//So we can use it
struct MessageWidgetView : View {
    let url: URL

    var body: some View {
        MessageWidgetWKWebView(url: url)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 315, maxHeight: 315)  // Should be part of the event
    }
}

struct MessageWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        MessageWidgetView(url: URL(string: "https://matrix.org")!)
    }
}
