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
    
    var thumbnailImage: Observable<UIImage?> = Observable(UIImage(systemName: "folder.fill"))
    
    var story: Story? {
        didSet {
            guard let multimediaArray = story?.multimedia else { return }
            let multimedia = multimediaArray.filter { $0.format == MultimediaImageTypes.largeThumbnail }.first
            guard let imageURL = multimedia?.url else { return }
            self.getImage(from: imageURL)
        }
    }
    
    
    var title: String {
        guard let title = story?.title else { return "" }
        return title
    }
    
    var abstract: String {
        guard let abstract = story?.abstract else { return "" }
        return abstract
    }
    
    func getImage(from url: String) {
        NetworkManager().getImageDataFromURL(from: url) { [weak self] data in
            if let data = data {
                self?.thumbnailImage.value = UIImage(data: data)
            }
        }
    }
}
