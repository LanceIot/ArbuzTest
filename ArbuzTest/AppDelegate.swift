//
//  AppDelegate.swift
//  ArbuzTest
//
//  Created by Pokerface on 21.05.2024.
//

import UIKit
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let appFactory: AppFactory = Di()

    private var appCoordinator: Coordinator?
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        FirebaseApp.configure()
        
        runUI()
        
        return true
    }
    
    private func runUI() {
        let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator()
        self.window = window
        self.appCoordinator = coordinator
        
        window.makeKeyAndVisible()
        coordinator.start()
    }
}

