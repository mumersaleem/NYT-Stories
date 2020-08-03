//
//  UITabBarItem.swift
//  nyt
//
//  Created by Umer Saleem on 31/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import UIKit

/// Extending UITabBarItem to accept TabBarContoller Type enum
extension UITabBarItem {
    convenience init(tabBarItem: TabBarController) {
        self.init(title: tabBarItem.tabBarItemTitle, image: tabBarItem.tabBarItemImage, selectedImage: tabBarItem.tabBarItemSelectedImage)
    }
}
