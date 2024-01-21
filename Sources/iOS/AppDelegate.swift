//
//  AppDelegate.swift
//  Example
//
//  Created by Merrick Sapsford on 04/10/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let gradientColors: [UIColor] = [.tabmanPrimary, .tabmanSecondary]
        
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 512, height: 512))
        window?.rootViewController = GradientBackgroundViewController(embedding: ButtonBarExampleViewController(), colors: gradientColors)
        window?.makeKeyAndVisible()
        
        return true
    }
}
