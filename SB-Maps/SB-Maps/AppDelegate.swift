//
//  AppDelegate.swift
//  SB-Maps
//
//  Created by Kerry Knight on 4/10/18.
//  Copyright © 2018 Kerry Knight. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let chooseDestinationViewController = ChooseDestinationViewController()
        let navController = UINavigationController(rootViewController: chooseDestinationViewController)
        let win = UIWindow(frame: UIScreen.main.bounds)
        win.rootViewController = navController
        win.makeKeyAndVisible()
        window = win
        
        setupGlobalStyles()
        
        return true
    }

    // MARK: - Private Methods
    func setupGlobalStyles() {
        let navBarAppearance = UINavigationBar.appearance()
        
        // make all nav bars solid white
        navBarAppearance.isTranslucent = false
        navBarAppearance.setBackgroundImage(UIImage.imageFromColor(.white), for: .default)
        
        // get rid of the default bottom border of the navigation bar
        navBarAppearance.shadowImage = UIImage()
    }
}

