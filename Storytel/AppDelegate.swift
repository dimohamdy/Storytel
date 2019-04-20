//
//  AppDelegate.swift
//  Storytel
//
//  Created by BinaryBoy on 4/17/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: BooksListBuilder.viewController(query: "Harry", dataSource: WebBooksRepository()))
        self.window?.makeKeyAndVisible()
        return true
    }

}

