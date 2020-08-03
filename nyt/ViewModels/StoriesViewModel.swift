//
//  StoriesViewModel.swift
//  nyt
//
//  Created by Umer Saleem on 28/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

class StoriesViewModel {
    
    var stories: Observable<[Story]> = Observable([Story]())
    var isLoading: Observable<Bool> = Observable(false)
    var errorStr: Observable<String> = Observable("")
    
    /// Type of the tab bar controller i.e. Home, health etc.
    var storyType: TabBarController? {
        didSet {
            switch storyType {
            case .offline:
                self.fetchOfflineStories(from: "offline")
            default:
                self.fetchLiveStories()
            }
        }
    }
    
    /// Number of rows in table view
    var numberOfRows: Int {
           stories.value.count
    }
    
    /// Navigation bar title
    var titleForHeader: String {
           guard let headerTitle = storyType?.viewHeaderTitle else { return "" }
           return headerTitle
    }
    
}

//MARK:- Private methods to retrive data from Network
extension StoriesViewModel {
    
    /// Getting live stories using  Network Manager
    private func fetchLiveStories() {
        self.isLoading.value = true
        NetworkManager.shared.getTopStories(type: storyType!.storyAPI) { [weak self] (stories, error) in
            guard let self = self else { return }
            self.isLoading.value = false
            guard let stories = stories, error == nil else {
                self.errorStr.value = error?.rawValue ?? NetworkResponse.failed.rawValue
                return
            }
            self.stories.value = stories
        }
    }
    
    /// Getting offline stories using Network Manager
    private func fetchOfflineStories(from file: String) {
        NetworkManager.shared.getOfflineStories(from: file) { [weak self] (stories, error) in
            guard let self = self else { return }
            guard let stories = stories, error == nil else {
                self.errorStr.value = error?.rawValue ?? NetworkResponse.failed.rawValue
                return
            }
            self.stories.value = stories
        }
    }

}
