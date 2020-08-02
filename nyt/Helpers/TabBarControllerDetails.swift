//
//  TabBarControllerDetails.swift
//  nyt
//
//  Created by Umer Saleem on 31/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import UIKit

protocol TabBarControllerDetails {
    var viewHeaderTitle: String { get }
    var tabBarItemTitle: String { get }
    var tabBarItemImage: UIImage? { get }
    var tabBarItemSelectedImage: UIImage? { get }
    var storyAPI: StoryAPI { get }
}

enum TabBarController {
    case home
    case sports
    case health
    case offline
}

extension TabBarController: TabBarControllerDetails {
    
    var viewHeaderTitle: String {
        switch self {
        case .home:
            return "Top Stories"
        case .sports:
            return "Sports Stories"
        case .health:
            return "Health Stories"
        case .offline:
            return "Offline Mode"
        }
    }
    
    var tabBarItemTitle: String {
        switch self {
        case .home:
            return "Home"
        case .sports:
            return "Sports"
        case .health:
            return "Health"
        case .offline:
            return "Offline"
        }
    }
    
    var tabBarItemImage: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "h.circle")
        case .sports:
            return UIImage(systemName: "sportscourt")
        case .health:
            return UIImage(systemName: "staroflife")
        case .offline:
            return UIImage(systemName: "bolt.horizontal.circle")
        }
    }
    
    var tabBarItemSelectedImage: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "h.circle.fill")
        case .sports:
            return UIImage(systemName: "sportscourt.fill")
        case .health:
            return UIImage(systemName: "staroflife.fill")
        case .offline:
            return UIImage(systemName: "bolt.horizontal.circle.fill")
        }
    }
    
    var storyAPI: StoryAPI {
        switch self {
        case .home:
            return .home
        case .sports:
            return .sports
        case .health:
            return .health
        case .offline:
            return .offline
        }
    }
}

