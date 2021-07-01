//
//  ALOApp.swift
//  ALO
//
//  Created by 이한결 on 2021/06/29.
//

import SwiftUI
import Firebase
import GoogleSignIn


@main
struct ALOApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SessionStore())

        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        print("Firebase...")
        FirebaseApp.configure()

        return true
    }
}


//원본
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions
//        launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//        print("Firebase...")
//        FirebaseApp.configure()
//
//        return true
//    }
//}
