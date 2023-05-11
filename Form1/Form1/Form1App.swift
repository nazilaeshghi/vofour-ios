//
//  Form1App.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@main
struct Form1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator.shared.makeTabbar()
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
