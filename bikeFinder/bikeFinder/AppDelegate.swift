//
//  AppDelegate.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navContoller = UINavigationController(rootViewController: HomeViewController.instantiate())
        window?.rootViewController = navContoller
        window?.makeKeyAndVisible()
        return true
    }
}
