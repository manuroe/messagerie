//
//  AnyIdentifiableView.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 20/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import SwiftUI

// https://medium.com/better-programming/meet-greet-advanced-lists-in-swiftui-80ab6f08ca03
struct AnyIdentifiableView: Identifiable, View {
    let id: AnyHashable
    let body: AnyView

    init<Item: Identifiable>(item: Item) where Item: View {
        id = item.id
        body = AnyView(item)
    }
}
