//
//  CustomTabbarController.swift
//  Task
//
//  Created by Tran Manh Quy on 02/05/2022.
//

import UIKit

class CustomTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension CustomTabbarController {

    static func build(_ screens: [UIViewController]) -> CustomTabbarController {
        let tabbar = CustomTabbarController()
        tabbar.viewControllers = screens
        return tabbar
    }
    
    static func buildForNormalAccount() -> CustomTabbarController {
        let tabbar = CustomTabbarController()
        tabbar.viewControllers = CustomTabbarController.makeScreensForNormalAccount()
        return tabbar
    }
    
    private static func makeScreensForNormalAccount() -> [UIViewController] {
        let screen1 = TaskListScreen()
        screen1.tabBarItem = UITabBarItem.init(tabBarSystemItem: .search, tag: 100)
        
        let screen2 = TaskListScreen()
        screen2.tabBarItem = UITabBarItem.init(tabBarSystemItem: .bookmarks, tag: 101)
        
        let screen3 = TaskListScreen()
        screen3.tabBarItem = UITabBarItem.init(tabBarSystemItem: .contacts, tag: 102)
        
        let screen4 = TaskListScreen()
        screen4.tabBarItem = UITabBarItem.init(tabBarSystemItem: .favorites, tag: 103)
        
        return [screen1, screen2, screen3, screen4]
    }
}
