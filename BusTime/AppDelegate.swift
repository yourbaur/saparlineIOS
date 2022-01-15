//
//  AppDelegate.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/14/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import IQKeyboardManager
import Firebase
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {

    var window: UIWindow?
    
    let gcmMessageIDKey = "gcm.message_id"
    static var deviceToken: String = String()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {window?.overrideUserInterfaceStyle = .light} else {}
        GMSServices.provideAPIKey("AIzaSyBhFliSpjTKO3hamDSHMFz8JmbAj7Nwe9U")
        
        IQKeyboardManager.shared().toolbarDoneBarButtonItemText = "Done"
        IQKeyboardManager.shared().isEnabled = true
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerForRemoteNotification(application: application)
        
        AppCenter.shared.createWindow(window!)
        if UserManager.shared.isSessionActive() {
            UserManager.shared.getTypeUser() == "driver" ? AppCenter.shared.startDriver() : AppCenter.shared.startCustomer()
        } else {
            AppCenter.shared.startAuth()
        }
        
        return true
    }
    
    func registerForRemoteNotification(application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
}


//  MARK: - notification
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken ?? "")")
        AppDelegate.deviceToken = fcmToken ?? ""

        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let info = userInfo[gcmMessageIDKey] {
            print(info)
        }
        print("userinfo no completionHandler", userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print("ios10 willPresent notification: ", userInfo)
        completionHandler([.alert, .badge, .sound])
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        if let info = userInfo[gcmMessageIDKey] { print(info) }
    
        print("userInfo with completionHandler", userInfo)
        
        if userInfo["type"] as! String == "reservation" {
            AppCenter.shared.makeNotRootController(type: "passenger")
        }
        else if userInfo["type"] as! String == "place_take" {
            AppCenter.shared.makeNotRootController(type: "passenger")
        }
        else if userInfo["type"] as! String == "driver_confirmation" {
            AppCenter.shared.makeNotRootController(type: "driver")
        }
        else if userInfo["type"] as! String == "feedback" {
            AppCenter.shared.makeNotRootController(type: "feedback", carId: userInfo["car_id"] as! String)
        }
        else if userInfo["type"] as! String == "push_to_driver" {
            UserManager.shared.setOrderId(to: userInfo["orderId"] as! String)
            UserManager.shared.setText(to: userInfo["title"] as! String)
            UserManager.shared.setConfirm(to: true)
            AppCenter.shared.makeNotRootController(type: "driver")
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
        
        switch application.applicationState {
        case UIApplication.State.active:
            print("")
        case UIApplication.State.background:
            print("")
        case UIApplication.State.inactive:
            print("")
        default:
            break
        }
    }
}
