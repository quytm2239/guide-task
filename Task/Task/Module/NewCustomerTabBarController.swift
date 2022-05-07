//
//  NewCustomerTabBarController.swift
//  Maby Business
//
//  Created by Trần Mạnh Quý on 10/21/20.
//

import UIKit

class NewCustomerTabBarController: UITabBarController {
    
    let indicator = UIView(frame: CGRect.zero)
    var arrayBarButton = [UIView]()
    var isIndicatorEnabled = false {
        didSet {
            indicator.isHidden = !isIndicatorEnabled
        }
    }
    var tabBarView = NewBottomTabBarView()
    var tabBarOldFrame = CGRect()
    
    func hideTabbarView() {
        if tabBarView.isHidden == true { return }
        tabBarView.isHidden = true
        tabBarView.transform = .init(translationX: 0, y: 100)
//        (NavCenter.topScreen as? BaseScreen)?.adjustBottomAnchor(hasBottomBar: false)
    }
    
    func showTabbarView() {
        if tabBarView.isHidden == false { return }
        tabBarView.isHidden = false
        tabBarView.transform = .identity
//        (NavCenter.topScreen as? BaseScreen)?.adjustBottomAnchor(hasBottomBar: true)
    }
    
    func animateShowTabbar() {
        if tabBarView.isHidden == false { return }
        tabBarView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.tabBarView.transform = .identity
        } completion: { (_) in
//            (NavCenter.topScreen as? BaseScreen)?.adjustBottomAnchor(hasBottomBar: true)
        }
    }
    
    func animateHideTabbar() {
        if tabBarView.isHidden == true { return }
        UIView.animate(withDuration: 0.3) {
            self.tabBarView.transform = .init(translationX: 0, y: 100)
            self.view.layoutIfNeeded()
        } completion: { (_) in
            self.tabBarView.isHidden = true
//            (NavCenter.topScreen as? BaseScreen)?.adjustBottomAnchor(hasBottomBar: false)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup custom tabbar
        let delta = CGFloat(0)
        let height = CGFloat(100) // 100 is standard height base on design
        let y = view.frame.size.height - height + delta
        tabBarOldFrame = CGRect(x: 0, y: y, width: view.frame.size.width, height: height)
        tabBarView = NewBottomTabBarView(frame: CGRect(x: 0, y: y, width: view.frame.size.width, height: height))
        tabBarView.screen = self
        view.addSubview(tabBarView)
    }
                
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateIndicator(tabBar, didSelect: item)
    }
    
    func showTabBar() {
        tabBarView.frame = tabBarOldFrame
        view.layoutIfNeeded()
    }
    
    func hideTabBar() {
        let bottomPadding = UIApplication.shared.windows[0].safeAreaInsets.bottom
        let y = bottomPadding + view.frame.size.height
        tabBarView.frame = CGRect(x: 0, y: y, width: tabBarOldFrame.size.width, height: tabBarOldFrame.size.height)
        view.layoutIfNeeded()
    }
    
    func updateIndicator(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if !isIndicatorEnabled { return }
        if arrayBarButton.isEmpty {
            arrayBarButton.append(contentsOf: tabBar.subviews.filter({ $0 is UIControl }))
        }
        print(selectedIndex)
        var selectedItem: UIView
        if item.tag < 0 || item.tag >= arrayBarButton.count {
            selectedItem = arrayBarButton[0]
        } else {
            selectedItem = arrayBarButton[item.tag]
        }
        var frame = selectedItem.bounds
        frame.size.height = 2
        indicator.frame = frame
        selectedItem.addSubview(indicator)
        indicator.backgroundColor = .blue
    }
    
    // MARK: - Static function for Initialization
    static func build(_ list: [UIViewController]) -> NewCustomerTabBarController {
        let tabbar = NewCustomerTabBarController()
        tabbar.tabBar.isHidden = true
        tabbar.viewControllers = list
        
        tabbar.tabBar.clipsToBounds = true
        tabbar.tabBar.backgroundColor = Color.Background.main // clears the background
        tabbar.tabBar.backgroundImage = UIImage()
//        tabbar.tabBar.shadowImage = UIImage()  // removes the border
        tabbar.tabBar.autoresizesSubviews = false
        
        return tabbar
    }
}

class NewCustomTabBarItem: UITabBarItem {
    
    static let defaultInset: UIEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
    
    func imageInset(_ inset: UIEdgeInsets = defaultInset) -> NewCustomTabBarItem {
        self.imageInsets = inset
        return self
    }
    
    func setTitleColor() -> NewCustomTabBarItem {
        let unselectedItem = [NSAttributedString.Key.foregroundColor: UIColor(hex: "#6C727F")]
        let selectedItem = [NSAttributedString.Key.foregroundColor: Color.Common.main]
        setTitleTextAttributes(unselectedItem, for: .normal)
        setTitleTextAttributes(selectedItem, for: .selected)
        return self
    }
}
