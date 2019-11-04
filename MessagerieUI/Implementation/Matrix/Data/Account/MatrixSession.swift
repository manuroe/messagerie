//
//  MatrixSession.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 02/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

import SwiftMatrixSDK

class MatrixSession {

    let matrixAccount: MatrixAccount
    let matrixRestClient: MXRestClient
    let session: MXSession

    private lazy var mediaManager: MXMediaManager = {
        MXMediaManager(homeServer: matrixAccount.homeserver.absoluteString)
    }()

    init(account: MatrixAccount) {
        matrixAccount = account

        let credentials = MXCredentials(homeServer: account.homeserver.absoluteString,
                                        userId: account.userId,
                                        accessToken: account.accessToken)
        
        matrixRestClient = MXRestClient(credentials: credentials, unrecognizedCertificateHandler: nil)
        session = MXSession(matrixRestClient: matrixRestClient)

        // Q: Expose start in Session protocol?
        start()
    }

    func start() {
        let store = MXFileStore()
        session.setStore(store) { _ in
            self.session.start() { _ in
            }
        }
    }
}

extension MatrixSession {

    func urlString(mxcString: String?, size: CGSize? = nil) -> String? {
        guard let mxcString = mxcString else {
            return nil
        }

        var urlString: String?
        if let size = size {
            urlString = mediaManager.url(ofContentThumbnail: mxcString, toFitViewSize: size, with: MXThumbnailingMethodScale)
        }
        else {
            urlString = mediaManager.url(ofContent: mxcString)
        }

        return urlString
    }
}
