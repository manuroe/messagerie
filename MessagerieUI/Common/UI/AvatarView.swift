//
//  avatarView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 12/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

import SDWebImage
import SDWebImageSwiftUI

struct AvatarView: View {
    let avatarUrl: URL?
    let width: CGFloat?
    let height: CGFloat?

    init(avatar: String?, width: CGFloat? = nil, height: CGFloat? = nil) {
        if let avatar = avatar {
            avatarUrl = URL(string: avatar)
        } else {
            avatarUrl = nil
        }
        self.width = width
        self.height = height
    }
    
    var body: some View {
        WebImage(url: avatarUrl)
            .resizable()
            .placeholder(Image(systemName: "photo"))
            .frame(width: width, height: height, alignment: .center)
            .scaledToFill()
            .clipShape(Circle())
    }
}

#if DEBUG
struct avatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(avatar: "https://matrix.org/matrix.png")
    }
}
#endif
