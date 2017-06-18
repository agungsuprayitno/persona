//
//  tabBarFooter.swift
//  Persona
//
//  Created by Agung Suprayitno on 6/16/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import Foundation
import UIKit

class customTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  setup custom Navigation Controller
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessageNavController = UINavigationController(rootViewController: friendsController)
        recentMessageNavController.title = "Recent"
        recentMessageNavController.tabBarItem.image = UIImage(named: "ic_watch_later_36pt")
        
        //  Add some item to
        let callController = createNavController(title: "Calls", imageName: "ic_call_36pt")
        let groupsController = createNavController(title: "Groups", imageName: "ic_people_36pt")
        let peopleController = createNavController(title: "People", imageName: "ic_account_box_36pt")
        let settingController = createNavController(title: "Settings", imageName: "ic_settings_36pt")
        
        viewControllers = [recentMessageNavController, callController, groupsController, peopleController, settingController]
        
    }
    
    func createNavController(title: String, imageName: String) -> UINavigationController {
        
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
        
    }
}
