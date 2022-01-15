//
//  AppDelegate.swift
//  FlowerApp
//
//  Created by Eslam Moemen on 9/11/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey:
        Any]?) -> Bool {
        
        var preferredStatusBarStyle: UIStatusBarStyle {
              return .lightContent
        }
        support.AppLangDefaultEnglish
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:appFont() ]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: appFont()], for: UIControl.State.normal)
        GMSServices.provideAPIKey("AIzaSyBGg--HyKcdgvFpIf_PsC9jS7gaAfTiP0g")
        IQKeyboardManager.shared.enable = true
        
        if support.checkUserId == true {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main")
            window?.rootViewController = sb
        }
        
        //ar - en
       
        if UserDefaults.standard.string(forKey: "visitapp") != nil {
            if support.currentDate() != (UserDefaults.standard.string(forKey: "visitapp")!) {
                api.visit(URL:visitUrl,date:support.currentDate(), softType: "2"){ (error, result, code) in
                    if code == 200 {
                        UserDefaults.standard.set(support.currentDate(), forKey: "visitapp")
                    }
                    
                }
            }
        }else {
            UserDefaultSetter(Value: "1", Key: "visitapp")
        }
        
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
                // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
                // Saves changes in the application's managed object context before the application terminates.
                self.saveContext()
            }

        // MARK: - Core Data stack
            lazy var persistentContainer: NSPersistentContainer = {
                /*
                 The persistent container for the application. This implementation
                 creates and returns a container, having loaded the store for the
                 application to it. This property is optional since there are legitimate
                 error conditions that could cause the creation of the store to fail.
                */
                let container = NSPersistentContainer(name: "CCartDataMdel")
                container.loadPersistentStores(completionHandler: { (storeDescription, error) in
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
                })
                return container
            }()

            // MARK: - Core Data Saving support
            func saveContext () {
                let context = persistentContainer.viewContext
                if context.hasChanges {
                    do {
                        try context.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
            }


        

    }





