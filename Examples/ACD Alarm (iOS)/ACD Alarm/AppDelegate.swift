//
//  AppDelegate.swift
//  ACD Alarm
//
//  Created by Vanderlei Martinelli on 2016-08-11.
//  Copyright © 2016 Alecrim. All rights reserved.
//

import UIKit
import CoreData

import AlecrimCoreData

let viewContext = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.addInitialData()
        
        //
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ACD_Alarm")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    // MARK: -
    
    private func addInitialData() {
        self.persistentContainer.performBackgroundTask { backgroundContext in
            func addAlarmType(withIdentifier identifier: String, name: String) {
                var alarmType: AlarmType! = backgroundContext.alarmTypes.first { $0.identifier == identifier }
                
                if alarmType == nil {
                    alarmType = backgroundContext.alarmTypes.create()
                    alarmType.identifier = identifier
                }
                
                alarmType.name = name
            }
            
            //
            addAlarmType(withIdentifier: "home", name: "Home")
            addAlarmType(withIdentifier: "work", name: "Work")
            
            //
            try! backgroundContext.save()
        }
    }

}
