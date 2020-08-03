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
    
    var numberOfRows: Int {
           stories.value.count
    }
       
    var titleForHeader: String {
           guard let headerTitle = storyType?.viewHeaderTitle else { return "" }
           return headerTitle
    }
    
}

//MARK:- Private methods to retrive data from Network
extension StoriesViewModel {
    
    private func fetchLiveStories() {
        self.isLoading.value = true
        NetworkManager().getTopStories(type: storyType!.storyAPI) { [weak self] (stories, error) in
            guard let self = self else { return }
            self.isLoading.value = false
            guard let stories = stories, error == nil else {
                self.errorStr.value = error?.rawValue ?? NetworkResponse.failed.rawValue
                return
            }
            self.stories.value = stories
        }
    }
    
    private func fetchOfflineStories(from file: String) {
        NetworkManager().getOfflineStories(from: file) { [weak self] (stories, error) in
            guard let self = self else { return }
            guard let stories = stories, error == nil else {
                self.errorStr.value = error?.rawValue ?? NetworkResponse.failed.rawValue
                return
            }
            self.stories.value = stories
        }
    }

}
