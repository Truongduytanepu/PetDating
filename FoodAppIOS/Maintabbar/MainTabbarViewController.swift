//
//  MainTabbarViewController.swift
//  FoodAppIOS
//
//  Created by Trương Duy Tân on 22/07/2023.
//

import UIKit
import ESTabBarController_swift

class MainTabbarViewController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        loadTabBarView()
        selectedIndex = 0
    }

    private func setupTabBarAppearance() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().tintColor = .lightGray
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }

    private func loadTabBarView() {
        let homeVC = createViewController(withIdentifier: "UserViewController", title: "", image: "home")
        let home1VC = createViewController(withIdentifier: "MessageViewController", title: "", image: "message")
        let home2VC = createViewController(withIdentifier: "ProfileViewController", title: "", image: "user")
        
        setViewControllers([homeVC, home1VC, home2VC], animated: true)
    }

    private func createViewController(withIdentifier: String, title: String, image: String) -> UIViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: withIdentifier)
        let image = UIImage(named: image)
        let selectedImage = image?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = ESTabBarItem(CustomStyleTabBarContentView(), title: title.uppercased(), image: image, selectedImage: selectedImage)
        viewController.tabBarItem = tabBarItem
        let nav = AppNavigationController(rootViewController: viewController)
        return nav
    }
}
