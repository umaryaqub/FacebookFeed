//
//  TabBarController.swift
//  Facebook Feed
//
//  Created by Umar Yaqub on 09/09/2018.
//  Copyright © 2018 Umar Yaqub. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let feedNavController = UINavigationController(rootViewController: feedController)
        feedNavController.title = "Feed"
        feedNavController.tabBarItem.image = UIImage(named: "FeedIcon")
        
        let friendRequestsController = FriendRequestsController()
        let friendRequestsNavController = UINavigationController(rootViewController: friendRequestsController)
        friendRequestsNavController.title = "Friend Requests"
        friendRequestsNavController.tabBarItem.image = UIImage(named: "RequestIcon")
        
        let messengerController = UIViewController()
        let messengerNavController = UINavigationController(rootViewController: messengerController)
        messengerNavController.title = "Messenger"
        messengerNavController.tabBarItem.image = UIImage(named: "MessengerIcon")
        
        let notificationController = UIViewController()
        let notificationNavController = UINavigationController(rootViewController: notificationController)
        notificationNavController.title = "Notification"
        notificationNavController.tabBarItem.image = UIImage(named: "NotificationIcon")
        
        let moreController = UIViewController()
        let moreNavController = UINavigationController(rootViewController: moreController)
        moreNavController.title = "More"
        moreNavController.tabBarItem.image = UIImage(named: "MoreIcon")
        
        viewControllers = [feedNavController, friendRequestsNavController, messengerNavController, notificationNavController, moreNavController]
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        
    }
}
