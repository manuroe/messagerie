//
//  MatrixSession.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 02/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation
import Combine

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
        credentials.deviceId = account.deviceId
        
        matrixRestClient = MXRestClient(credentials: credentials, unrecognizedCertificateHandler: nil)
        session = MXSession(matrixRestClient: matrixRestClient)
    }


    var sessionStateObserver: NSObjectProtocol?
    func dataReadyFuture() -> Future<MXSessionState, Never> {
        return Future<MXSessionState, Never> { promise in

            // TODO: Could be certainly more Combiny
            if self.session.state.rawValue >= MXSessionStateStoreDataReady.rawValue {
                promise(.success(self.session.state))
                return
            }

            if self.session.state == MXSessionStateInitialised {
                self.startSession()
            }

            self.sessionStateObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.mxSessionStateDidChange, object: self.session, queue: nil) { (_) in
                if self.session.state.rawValue >= MXSessionStateStoreDataReady.rawValue {
                    promise(.success(self.session.state))
                }
            }
        }
    }

    
    private func startSession() {
        let store = MXFileStore()
        session.setStore(store) { _ in

            // For testing
            //store.deleteAllData()

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
