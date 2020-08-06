//
//  DetailViewController.swift
//  nyt
//
//  Created by Umer Saleem on 01/08/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    lazy var viewModel = DetailViewModel()

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    /// Update labels alignment based on orientation
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if UIDevice.current.orientation.isLandscape {
            titleLabel.textAlignment = .center
            captionLabel.textAlignment = .center
        } else {
            titleLabel.textAlignment = .left
            captionLabel.textAlignment = .left
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .plain, target: self, action: #selector(handleWebView))
    }
}

//MARK:- Binding view model with view
extension DetailViewController {
    func bindViewModel() {
        
        titleLabel.textColor = .label
        titleLabel.text = viewModel.title
        captionLabel.textColor = .secondaryLabel
        captionLabel.text = viewModel.caption
        
        self.viewModel.mainImage.bind { [weak self ] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.mainImageView.image = image
            }
        }
    }
}
//MARK:- Navigate to webView
extension DetailViewController {
    @objc private func handleWebView() {
        let webViewVC = WebViewController()
        webViewVC.viewModel.urlString = viewModel.story?.url
        show(webViewVC, sender: nil)
    }
}
