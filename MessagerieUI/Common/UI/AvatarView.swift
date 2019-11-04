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

    init(avatarUrl: String?) {

        if let avatarUrl = avatarUrl {
            self.imageLoader.loadUrl(urlString: avatarUrl)
        }
    }

    var body: some View {
        Image(uiImage: self.imageLoader.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)   // TODO: Should be a param
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
