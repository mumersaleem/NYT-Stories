//
//  StoryTableViewCell.swift
//  nyt
//
//  Created by Umer Saleem on 29/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    
    var viewModel = StoryCellViewModel()
    
    /// Setting labels' texts after awakening from nib
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        resetCell()
    }
    
    override func prepareForReuse() {
        resetCell()
    }
    
    /// Reset the cell to empty labels
    private func resetCell() {
        titleLabel.text = ""
        thumbnailImageView.image = UIImage(named: "placeHolderImage")
    }
    
    func configureCell() {
        
        /// cell view layer changes for better UI
        cellView.layer.cornerRadius = 20
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor.lightGray.cgColor
        cellView.layer.shadowRadius = 4
        cellView.layer.shadowColor = UIColor.gray.cgColor
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowOffset = .zero
        
        thumbnailImageView.layer.cornerRadius = 6
        thumbnailImageView.layer.borderWidth = 1
        thumbnailImageView.layer.borderColor = UIColor.lightGray.cgColor
        thumbnailImageView.layer.shadowRadius = 2
        thumbnailImageView.layer.shadowColor = UIColor.gray.cgColor
        thumbnailImageView.layer.shadowOpacity = 0.5
        thumbnailImageView.layer.shadowOffset = .zero
        
        
        /// Setting labels texts
        titleLabel.text = viewModel.title

        /// Binding ViewModel
        bindViewModel()
    }
}

extension StoryTableViewCell {
    func bindViewModel() {
        viewModel.thumbnailImage.bind { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
    }
}
