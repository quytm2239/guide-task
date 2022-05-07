//
//  AppDelegate.swift
//  Task
//
//  Created by Tran Manh Quy on 01/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    typealias Thing = [String:Any]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CustomTabbarController.buildForNormalAccount()
        window?.makeKeyAndVisible()

//        var nsDictionary: NSDictionary?
//        if let path = Bundle.main.path(forResource: "Environment", ofType: "plist") {
//           nsDictionary = NSDictionary(contentsOfFile: path)
//        }
//        print(nsDictionary!)
//
//        let mainPlist = Bundle.main.object(forInfoDictionaryKey: "Payment_Key") as! String
//        print("Payment key: \(mainPlist)")
        
        return true
    }
}

