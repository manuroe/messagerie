//
//  LoginViewModelType.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 17/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

protocol LoginViewModelType {
    var state: LoginViewState { get }
    var onNewAccount: (AccountType) -> Void { get set }

    func process(viewAction: LoginViewAction)
}
