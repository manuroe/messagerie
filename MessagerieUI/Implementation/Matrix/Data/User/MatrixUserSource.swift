//
//  MatrixUserSource.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 05/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation
import Combine

import SwiftMatrixSDK

class MatrixUserSource: UserSourceType {

    private let subject = PassthroughSubject<User, Never>()
    var publisher : AnyPublisher<User, Never> {
        return subject.eraseToAnyPublisher()
    }

    private let session: MatrixSession
    private let mxSession: MXSession
    private let userId: String

    private var mxUser: MXUser?

    init(session: MatrixSession, userId: String) {
        self.session = session
        mxSession = session.session
        self.userId = userId
    }

    func load() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.mxSessionStateDidChange, object: mxSession, queue: nil) { (_) in
            self.update()
        }

        if (mxSession.state.rawValue >= MXSessionStateStoreDataReady.rawValue) {
            update()
        }
    }

    func update() {
        if mxUser == nil {
            mxUser = mxSession.user(withUserId: userId)
        }

        if let mxUser = mxUser {
            let user = buildUser(from: mxUser)
            subject.send(user)
        }
    }

    private func buildUser(from mxUser: MXUser) -> User {
        let size = CGSize(width: 40, height: 40) // TODO: Must be driven by the UI

        return User(userId: mxUser.userId,
                    displayname: mxUser.displayname,
                    avatar: session.urlString(mxcString: mxUser.avatarUrl, size: size) ?? "https://matrix.org/matrix.png")
    }
}
