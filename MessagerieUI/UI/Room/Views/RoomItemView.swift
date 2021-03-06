//
//  RoomItemView.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 22/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import SwiftUI

struct RoomItemView: View {
    var item: RoomItem
    var body: some View {
        itemContentView()
    }

    func itemContentView() -> AnyView {
        switch item {
        case .message(let message):
            return AnyView(
                MessageView(message: message)
            )
        case .null:
            return AnyView(
                NullView()
            )
        }
    }
}

struct RoomItemView_Previews: PreviewProvider {
    static var previews: some View {
        Text("TODO")
    }
}
