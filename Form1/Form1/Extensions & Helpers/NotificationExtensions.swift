//
//  NotificationExtensions.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
extension Notification.Name {
    static var cloceClick: Notification.Name { Notification.Name.init("CloceClick") }
    static var dataChange: Notification.Name { Notification.Name.init("dataChange") }
}

extension NotificationCenter {
    static func sendNotification(for name: Notification.Name) {
        NotificationCenter.default.post(name: name, object: nil)
    }
}
