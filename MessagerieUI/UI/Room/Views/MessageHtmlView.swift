//
//  MessageHtmlView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 29/08/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import SwiftUI
import WebKit


struct MessageHtmlView: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        //let htmlString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>" + html
        uiView.loadHTMLString(html, baseURL: nil)
    }
}

#if DEBUG
struct MessageHtmlView_Previews: PreviewProvider {
    static var previews: some View {
        MessageHtmlView(html: "<strong>Hello World!</strong>")
    }
}
#endif
