//
//  MessageTextView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 13/08/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import SwiftUI

struct MessageTextView: View {
    let message: String
    
    var body: some View {
        Text(self.message)
            .font(.subheadline)
            .lineLimit(nil)
    }
}

#if DEBUG
struct MessageTextView_Previews: PreviewProvider {
    static var previews: some View {
        MessageTextView(message: "Hello World!")
    }
}
#endif
