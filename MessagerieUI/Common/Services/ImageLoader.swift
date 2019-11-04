//
//  DataLoader.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 12/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI
import Combine

import Alamofire
import AlamofireImage

class ImageLoader: ObservableObject {

    @Published var image = UIImage()

    func loadUrl(urlString: String) {
        Alamofire.request(urlString).responseImage { response in
            debugPrint(response)

            if let image = response.result.value {
                self.image = image
            }
        }
    }
}
