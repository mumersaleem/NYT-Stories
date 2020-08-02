//
//  MainViewController.swift
//  nyt
//
//  Created by Umer Saleem on 29/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarControllers()
    }
}


//MARK:- Set up tab bar controllers 
extension MainViewController {
    private func setTabBarControllers() {
        let homeVC = UIStoryboard(name: SegueIdentifiers.main, bundle: nil).instantiateViewController(withIdentifier: SegueIdentifiers.storiesViewController) as! StoriesViewController
        homeVC.storyType = .home
        homeVC.tabBarItem = UITabBarItem(tabBarItem: .home)
        
        let sportsVC = UIStoryboard(name: SegueIdentifiers.main, bundle: nil).instantiateViewController(withIdentifier: SegueIdentifiers.storiesViewController) as! StoriesViewController
        sportsVC.storyType = .sports
        sportsVC.tabBarItem = UITabBarItem(tabBarItem: .sports)
        
        let healthVC = UIStoryboard(name: SegueIdentifiers.main, bundle: nil).instantiateViewController(withIdentifier: SegueIdentifiers.storiesViewController) as! StoriesViewController
        healthVC.storyType = .health
        healthVC.tabBarItem = UITabBarItem(tabBarItem: .health)
        
        let offlineVC = UIStoryboard(name: SegueIdentifiers.main, bundle: nil).instantiateViewController(withIdentifier: SegueIdentifiers.storiesViewController) as! StoriesViewController
        offlineVC.storyType = .offline
        offlineVC.tabBarItem = UITabBarItem(tabBarItem: .offline)
        
        setViewControllers([homeVC, sportsVC, healthVC, offlineVC], animated: true)
    }
}
