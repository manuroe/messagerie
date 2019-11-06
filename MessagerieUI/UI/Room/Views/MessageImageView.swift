//
//  MessageImageView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 12/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct MessageImageView: View {
    @ObservedObject private var imageLoader = ImageLoader()

    init(urlString: String) {
        self.imageLoader.loadUrl(urlString: urlString)
    }

    var body: some View {
        Image(uiImage: self.imageLoader.image)
            .aspectRatio(contentMode: .fit)
    }
}

#if DEBUG
struct MessageImageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageImageView(urlString: "https://matrix.org/matrix.png")
    }
}
#endif
