//
//  MockUserSource.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 05/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation
import Combine

struct MockUserSource: UserSourceType {

    private let subject = PassthroughSubject<User, Never>()
    var publisher : AnyPublisher<User, Never> {
        return subject.eraseToAnyPublisher()
    }

    func load() {
        let user = User(userId: "1", displayname: "My User", avatar: "https://matrix.org/matrix.png")
        subject.send(user)
    }
}
