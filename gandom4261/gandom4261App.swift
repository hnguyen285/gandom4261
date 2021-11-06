//
//  gandom4261App.swift
//  gandom4261
//
//  Created by Hao Nguyen on 11/6/21.
//

import SwiftUI
import Firebase

@main
struct gandom4261App: App {
   @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
   
    var body: some Scene {
        WindowGroup {
           let viewModel = SigninViewModel()
            ContentView()
              .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
      FirebaseApp.configure()
      return true
   }
}
