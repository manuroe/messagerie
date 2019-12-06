//
//  TimelineUpdate.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 01/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation

enum MessagesUpdate {
    case backwards(messages: [Message])
    case forwards(messages: [Message])
    case update(messages: [Message])    // TODO: Should we differentiate content update (redact, edit) from RR or reactions update?
    case deletion(eventIds: [String])
}
