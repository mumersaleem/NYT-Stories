//
//  DetailViewController.swift
//  nyt
//
//  Created by Umer Saleem on 01/08/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var viewModel = DetailViewModel()

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layerChanges()
        bindViewModel()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .plain, target: self, action: #selector(tapped))
    }
    
    @objc func tapped() {
        UIApplication.shared.open(URL(string: "https://www.google.com")!)
    }
}

extension DetailViewController {
    func layerChanges() {
        titleView.layer.cornerRadius = 12
        titleView.layer.borderWidth = 1
        titleView.layer.borderColor = UIColor.lightGray.cgColor
        titleView.layer.shadowRadius = 2
        titleView.layer.shadowColor = UIColor.gray.cgColor
        titleView.layer.shadowOpacity = 0.5
        titleView.layer.shadowOffset = .zero
        
        thumbnailImageView.layer.cornerRadius = 6
        thumbnailImageView.layer.borderWidth = 1
        thumbnailImageView.layer.borderColor = UIColor.lightGray.cgColor
        thumbnailImageView.layer.shadowRadius = 2
        thumbnailImageView.layer.shadowColor = UIColor.gray.cgColor
        thumbnailImageView.layer.shadowOpacity = 0.5
        thumbnailImageView.layer.shadowOffset = .zero
    }
}

extension DetailViewController {
    func bindViewModel() {
        
        titleLabel.text = viewModel.title
        captionLabel.text = viewModel.caption
        self.viewModel.thumbnailImage.bind { image in
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
        
        self.viewModel.mainImage.bind { image in
            DispatchQueue.main.async {
                self.mainImageView.image = image
            }
        }
    }
}

extension DetailViewController {
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
}
