//
//  avatarView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 12/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    @ObservedObject private var imageLoader = ImageLoader()

    let width: CGFloat?
    let height: CGFloat?

    init(avatarUrl: String?, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.width = width
        self.height = height

        if let avatarUrl = avatarUrl {
            imageLoader.loadUrl(urlString: avatarUrl)
        }
    }

    var body: some View {
        Image(uiImage: imageLoader.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipShape(Circle())
    }
}

#if DEBUG
struct avatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(avatarUrl: "https://matrix.org/matrix.png")
    }
}
#endif
