//
//  Form1App.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//

import SwiftUI
import IQKeyboardManagerSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
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
