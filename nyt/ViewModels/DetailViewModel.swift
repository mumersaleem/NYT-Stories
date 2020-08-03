//
//  DetailViewModel.swift
//  nyt
//
//  Created by Umer Saleem on 01/08/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import UIKit

class DetailViewModel {
    
    /// Bindable objects for thumbnail and main Image
//    var thumbnailImage: Observable<UIImage?> = Observable(UIImage(named: "placeHolderImage"))
    var mainImage: Observable<UIImage?> = Observable(UIImage(named: "placeHolderImage"))

    var story: Story? {
        didSet {
            setMediaImages()
        }
    }
    
    var caption: String? {
        /// Caption of the image from multimedia list. All captions are same so using first object in list to retrieve caption.
        story?.multimedia?.first?.caption
    }
    
    var title: String? {
        /// Title for the story
        story?.title
    }
}

//MARK:- Private functions to set and get data from Network
extension DetailViewModel {

    private func setMediaImages() {
        /// Getting thumbnail image from multimedia
        guard let multimediaArray = story?.multimedia else { return }
//        let thumbnailMedia = multimediaArray.filter { $0.format == MultimediaImageTypes.largeThumbnail }.first
//        guard let thumbnailImageURL = thumbnailMedia?.url else { return }
//        self.getImage(from: thumbnailImageURL) { [weak self] image in
//            self?.thumbnailImage.value = image
//        }
        
        /// Getting main image from multimedia
        let mainMedia = multimediaArray.filter { $0.format == MultimediaImageTypes.superJumbo }.first
        guard let mainImageURL = mainMedia?.url else { return }
        self.getImage(from: mainImageURL) { [weak self] image in
            self?.mainImage.value = image
        }
    }
    
    private func getImage(from url: String, completion: @escaping (UIImage?) -> ()) {
        NetworkManager().getImageDataFromURL(from: url) { data in
            if let data = data {
                completion(UIImage(data: data))
            }
        }
    }
    
    @objc func openStory() {
        guard let urlString = story?.url, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}
