//
//  AppDelegate.swift
//  TastingNotes
//
//  Created by David Burke on 8/3/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let testMode = ProcessInfo().arguments.contains("UI Test")
        let navController = window!.rootViewController as! UINavigationController
        let tableViewController = navController.topViewController as! TastingSessionsVC
        let tastingNotesMoc = TastingNotesManagedObjectContext(testmode: testMode)
        let tastingSessionsStore = TastingSessionStore(usingManagedObjectContext: tastingNotesMoc.moc)
        tableViewController.sessionStore = tastingSessionsStore
        tableViewController.sessionStore.frc.delegate = tableViewController
        
        let grapeStore = GrapeStore(usingManagedObjectContext: tastingNotesMoc.moc)
        if grapeStore.count() == 0 {
            grapeStore.importCSV()
        }
        tableViewController.grapeStore = grapeStore
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
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
    }

    // MARK: - Core Data Saving support

}
