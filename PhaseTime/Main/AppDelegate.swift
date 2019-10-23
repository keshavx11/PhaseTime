//
//  AppDelegate.swift
//  PhaseTime
//
//  Created by Keshav Bansal on 09/07/18.
//  Copyright © 2018 Keshav Bansal. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBAYNVEKgTHK6DpjyJEvMaU0udfY0RVXxc")
        GMSPlacesClient.provideAPIKey("AIzaSyBAYNVEKgTHK6DpjyJEvMaU0udfY0RVXxc")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}
