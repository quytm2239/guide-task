//
//  BottomTabbarView.swift
//  Maby Business
//
//  Created by Trần Mạnh Quý on 10/21/20.
//

import UIKit

enum BottomTabbarViewTag: Int, CaseIterable {
    case tab1 = 101
    case tab2 = 102
    case tab3 = 103
    case tab4 = 104
    case tab5 = 105
}

/// from 2 - 5 tabs
func getRatioByVisibleTab(_ count: Int) -> (expand: CGFloat, collapse: CGFloat) {
    switch count {
    case 2: return (expand: 0.7, collapse: 0.3)
    case 3: return (expand: 0.5, collapse: 0.25)
    case 4: return (expand: 0.4, collapse: 0.2)
    case 5: return (expand: 0.4, collapse: 0.15)
    default: return (expand: 1, collapse: 0)
    }
}

class NewBottomTabBarView: NibView {
    
    @IBOutlet var rootView: SmoothPartialCornerView!
    var currentTab: BottomTabbarViewTag = .tab1
    unowned var screen: NewCustomerTabBarController!

    // MARK: - IBOutlets
    @IBOutlet weak var widthTab1: NSLayoutConstraint!
    @IBOutlet weak var widthTab2: NSLayoutConstraint!
    @IBOutlet weak var widthTab3: NSLayoutConstraint!
    @IBOutlet weak var widthTab4: NSLayoutConstraint!
    @IBOutlet weak var widthTab5: NSLayoutConstraint!

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var tab1: UIView!
    @IBOutlet weak var viewTab1: UIStackView!
    @IBOutlet weak var btnTab1: UIButton!
    @IBOutlet weak var labelTab1: UILabel!


    @IBOutlet weak var tab2: UIView!
    @IBOutlet weak var viewTab2: UIStackView!
    @IBOutlet weak var btnTab2: UIButton!
    @IBOutlet weak var labelTab2: UILabel!

    @IBOutlet weak var tab3: UIView!
    @IBOutlet weak var viewTab3: UIStackView!
    @IBOutlet weak var btnTab3: UIButton!
    @IBOutlet weak var labelTab3: UILabel!

    @IBOutlet weak var tab4: UIView!
    @IBOutlet weak var viewTab4: UIStackView!
    @IBOutlet weak var btnTab4: UIButton!
    @IBOutlet weak var labelTab4: UILabel!

    @IBOutlet weak var tab5: UIView!
    @IBOutlet weak var viewTab5: UIStackView!
    @IBOutlet weak var btnTab5: UIButton!
    @IBOutlet weak var labelTab5: UILabel!

    var visibleTabs: [BottomTabbarViewTag] = BottomTabbarViewTag.allCases {
        didSet {
            if visibleTabs.count < 2 { return }
            self.stackView.subviews.forEach({ $0.isHidden = true })
            for item in visibleTabs {
                if let view = self.stackView.viewWithTag(item.rawValue) {
                    view.isHidden = false
                }
            }
            
            let first = visibleTabs.first!
            setDefaultTab(index: first)
        }
    }
    
    var ratio: (expand: CGFloat, collapse: CGFloat) {
        return getRatioByVisibleTab(self.visibleTabs.count)
    }
    
    var maxWidth: CGFloat {
        return UIScreen.main.bounds.width - 20
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelTab1.text = "Kho"
        if #available(iOS 13.0, *) {
            rootView.layer.cornerCurve = .continuous
        } else {
            // Fallback on earlier versions
        }
        setClickHandler()
        collapseAllTab()
        setDefaultTab()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func removeTitles() {
//        btnTab1.setTitle("", for: .normal)
//        btnTab1.backgroundColor = .white
//        btnTab1.setImage(RImage.ic_home_tabbar(), for: .normal)
//
//        btnTab2.setTitle("", for: .normal)
//        btnTab2.backgroundColor = .white
//        btnTab2.setImage(RImage.ic_invoice_tabbar(), for: .normal)
//
//        btnTab3.setTitle("", for: .normal)
//        btnTab3.backgroundColor = .white
//        btnTab3.setImage(RImage.ic_delivery_tabbar(), for: .normal)
//
//        btnTab4.setTitle("", for: .normal)
//        btnTab4.backgroundColor = .white
//        btnTab4.setImage(RImage.ic_notification_tabbar(), for: .normal)
//
//        btnTab5.setTitle("", for: .normal)
//        btnTab5.backgroundColor = .white
//        btnTab5.setImage(RImage.ic_profile_tabbar(), for: .normal)
//        labelTab1.text = ""
//        viewTab1.backgroundColor = .white
//
//        labelTab2.text = ""
//        viewTab2.backgroundColor = .white
//
//        labelTab3.text = ""
//        viewTab3.backgroundColor = .white
//
//        labelTab4.text = ""
//        viewTab4.backgroundColor = .white
//
//        labelTab5.text = ""
//        viewTab5.backgroundColor = .white
    }
    
    private func setClickHandler() {
        tab1.onClick { (_) in self.clickTab1() }
        tab2.onClick { (_) in self.clickTab2() }
        tab3.onClick { (_) in self.clickTab3() }
        tab4.onClick { (_) in self.clickTab4() }
        tab5.onClick { (_) in self.clickTab5() }
    }
    
    func collapseAllTab() {
        
        let ratio = self.ratio
        widthTab1.constant = maxWidth * ratio.collapse
        widthTab2.constant = maxWidth * ratio.collapse
        widthTab3.constant = maxWidth * ratio.collapse
        widthTab4.constant = maxWidth * ratio.collapse
        widthTab5.constant = maxWidth * ratio.collapse
        
        tab1.backgroundColor = .clear
        tab2.backgroundColor = .clear
        tab3.backgroundColor = .clear
        tab4.backgroundColor = .clear
        tab5.backgroundColor = .clear

        labelTab1.isHidden = true
        labelTab2.isHidden = true
        labelTab3.isHidden = true
        labelTab4.isHidden = true
        labelTab5.isHidden = true
    }
    
    func clickTab1() {
        screen.selectedIndex = 1 // tab booking in TabbarVC
        
        removeTitles()
        
        self.currentTab = .tab1
        self.collapseAllTab()
        
        self.labelTab1.isHidden = false // diactive First then active the expanding width
        self.labelTab1.text = "Kho"

        self.widthTab1.constant = self.ratio.expand * maxWidth
        self.tab1.backgroundColor = UIColor.init(hex: "05294A")

        animateWithBouncing(0.6) { [weak self] in
            guard let self = self else {return}
            self.stackView.layoutIfNeeded()
        }
    }
    
    func clickTab2() {
        screen.selectedIndex = 2 // tab favorite in TabbarVC
        
        removeTitles()
        
        self.currentTab = .tab2
        self.collapseAllTab()
        
        self.labelTab2.isHidden = false // diactive First then active the expanding width
        self.labelTab2.text = "Hoá đơn"

        self.widthTab2.constant = self.ratio.expand * maxWidth
        self.tab2.backgroundColor = UIColor.init(hex: "05294A")

        animateWithBouncing(0.6) { [weak self] in
            guard let self = self else {return}
            self.stackView.layoutIfNeeded()
        }
    }
    
    private func setDefaultTab(index: BottomTabbarViewTag) {
        switch index {
        case .tab1: clickTab1()
        case .tab2: clickTab2()
        case .tab3: clickTab3()
        case .tab4: clickTab4()
        case .tab5: clickTab5()
        }
    }
    
    private func setDefaultTab() {
        removeTitles()
//        btnTab3.backgroundColor = UIColor(hex: "#F8CDBA")
//        btnTab3.setImage(RImage.ic_delivery_tabbar(), for: .normal)
//        btnTab3.tintColor = UIColor(hex: "#283B21")
//        btnTab3.setTitle("Giao nhận", for: .normal)

        self.currentTab = .tab1
        collapseAllTab()
        
        self.widthTab1.constant = self.ratio.expand * maxWidth
        labelTab1.isHidden = false // diactive First then active the expanding width
        
        tab1.backgroundColor = UIColor.init(hex: "05294A")
        labelTab1.text = "Kho"
//        widthExpandOfTab3.isActive = true
    }
    
    func clickTab3() {
        screen?.selectedIndex = 0 // tab home in TabbarVC
        
        removeTitles()
//        btnTab3.backgroundColor = UIColor(hex: "#F8CDBA")
//        btnTab3.setImage(RImage.ic_delivery_tabbar(), for: .normal)
//        btnTab3.tintColor = UIColor(hex: "#283B21")
//        btnTab3.setTitle("Giao nhận", for: .normal)
        
        self.currentTab = .tab3
        self.collapseAllTab()
        
        self.labelTab3.isHidden = false // diactive First then active the expanding width
        self.labelTab3.text = "Giao nhận"

        self.widthTab3.constant = self.ratio.expand * maxWidth
        self.tab3.backgroundColor = UIColor.init(hex: "05294A")

        animateWithBouncing(0.6) { [weak self] in
            guard let self = self else {return}
            self.stackView.layoutIfNeeded()
        }
    }
    
    func clickTab4() {
        self.screen.selectedIndex = 3 // tab mail/noti in TabbarVC
        
        self.removeTitles()
//        btnTab4.backgroundColor = UIColor(hex: "#F8CDBA")
//        btnTab4.setImage(RImage.ic_notification_tabbar(), for: .normal)
//        btnTab4.tintColor = UIColor(hex: "#283B21")
//        btnTab4.setTitle("Thông báo", for: .normal)

        self.currentTab = .tab4
        self.collapseAllTab()
        
        self.labelTab4.isHidden = false // diactive First then active the expanding width
        self.labelTab4.text = "Thông báo"

        self.widthTab4.constant = self.ratio.expand * maxWidth
        self.tab4.backgroundColor = UIColor.init(hex: "05294A")

        animateWithBouncing(0.6) { [weak self] in
            guard let self = self else {return}
            self.stackView.layoutIfNeeded()
        }
    }
    
    /// * Profile tab
    func clickTab5() {
//        if !checkBeforeSelect() { return }
        
        self.screen.selectedIndex = 4 // tab profile in TabbarVC
        self.removeTitles()
//        btnTab4.backgroundColor = UIColor(hex: "#F8CDBA")
//        btnTab4.setImage(RImage.ic_notification_tabbar(), for: .normal)
//        btnTab4.tintColor = UIColor(hex: "#283B21")
//        btnTab4.setTitle("Thông báo", for: .normal)

        self.currentTab = .tab5
        self.collapseAllTab()
        
        self.labelTab5.isHidden = false // diactive First then active the expanding width
        self.labelTab5.text = "Hồ sơ"

        self.widthTab5.constant = self.ratio.expand * maxWidth
        self.tab5.backgroundColor = UIColor.init(hex: "05294A")

        animateWithBouncing(0.6) { [weak self] in
            guard let self = self else {return}
            self.stackView.layoutIfNeeded()
        }
    }
    
    private func checkBeforeSelect() -> Bool {
        if AppCache.isLoggedIn { return true }
//        NavCenter.openLoginScreen()
        return false
    }
}
