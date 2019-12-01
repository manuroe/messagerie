//
//  MXRoomSummary+Messagerie.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 01/12/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

import SwiftMatrixSDK

extension MXRoomSummary {
    struct Constants {
        static let lastMessageKey = "lastMessage"
    }

    var mss_lastMessage: Message? {
        get {
            var lastMessage: Message?
            do {
                if let data = self.others?[Constants.lastMessageKey] as? Data {
                    lastMessage = try JSONDecoder().decode(Message.self, from: data)
                }
            } catch {
            }
            return lastMessage
        }

        set {
            do {
                self.others[Constants.lastMessageKey] = try JSONEncoder().encode(newValue)
            } catch {
            }
        }
    }
}
