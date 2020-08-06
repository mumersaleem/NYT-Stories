//
//  StoryCellViewModel.swift
//  nyt
//
//  Created by Umer Saleem on 29/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation
import UIKit

class StoryCellViewModel {
    
    /// Bindable objects for thumbnail image
    var thumbnailImage: Observable<UIImage?> = Observable(UIImage(named: "placeHolderImage"))
    
    var story: Story? {
        didSet {
            guard let multimediaArray = story?.multimedia else { return }
            let multimedia = multimediaArray.filter { $0.format == MultimediaImageTypes.largeThumbnail }.first
            guard let imageURL = multimedia?.url else { return }
            self.getImage(from: imageURL)
        }
    }
    
    /// Title of the story
    var title: String {
        guard let title = story?.title else { return "" }
        return title
    }
    
    /// Abstract of the story, this property can be used to show the abstract of the story.
//    var abstract: String {
//        guard let abstract = story?.abstract else { return "" }
//        return abstract
//    }
    
    /// Getting image from string url using Network Manager
    func getImage(from url: String) {
        NetworkManager.shared.getImageDataFromURL(from: url) { [weak self] data in
            guard let self = self else { return }
            if let data = data {
                self.thumbnailImage.value = UIImage(data: data)
            }
        }
    }
}
