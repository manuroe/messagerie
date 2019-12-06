//
//  MessageImageView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 12/08/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import SwiftUI

import SDWebImage
import SDWebImageSwiftUI

struct MessageImageView: View {
    let url: URL?

    init(urlString: String) {
        url = URL(string: urlString)
    }

    var body: some View {
        WebImage(url: url)
//            .placeholder {
//                Rectangle().foregroundColor(.gray)
//            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(5)
    }
}

#if DEBUG
struct MessageImageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageImageView(urlString: "https://matrix.org/matrix.png")
    }
}
#endif
