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
    var webView = WKWebView(frame: UIScreen.main.bounds)

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
//    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .plain, target: self, action: #selector(handleWebView))
        view.addSubview(webView)
        webView.isHidden = true

    }
}

//MARK:- Binding view model with view
extension DetailViewController {
    func bindViewModel() {
        
        titleLabel.text = viewModel.title
        captionLabel.text = viewModel.caption
//        self.viewModel.thumbnailImage.bind { [weak self] image in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                self.thumbnailImageView.image = image
//            }
//        }
        
        self.viewModel.mainImage.bind { [weak self ] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.mainImageView.image = image
            }
        }
    }
}

//MARK:- Loading WKWebView to show the story in application
extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
        navigationItem.rightBarButtonItem?.isEnabled = true
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        print(error.localizedDescription)
    }
}

//MARK:- Orientation Handling
extension DetailViewController {
    @objc private func handleWebView() {
        if webView.isHidden {
            webView.isHidden = false
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "multiply.circle.fill")
            guard let urlString = viewModel.story?.url, let url = URL(string: urlString) else { return }
            let urlRequest = URLRequest(url: url)
            
            webView.allowsBackForwardNavigationGestures = true
            webView.navigationDelegate = self
            webView.load(urlRequest)
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "info.circle.fill")
            webView.isHidden = true
        }
    }
}

//MARK:- Orientation Handling
extension DetailViewController {
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
//        mainImageView.translatesAutoresizingMaskIntoConstraints = false
//        captionLabel.translatesAutoresizingMaskIntoConstraints = false
//        if UIDevice.current.orientation.isLandscape {
//            NSLayoutConstraint.activate([
//                NSLayoutConstraint(item: mainImageView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: 0),
//                NSLayoutConstraint(item: mainImageView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 0),
////                NSLayoutConstraint(item: mainImageView!, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 20),
//                NSLayoutConstraint(item: mainImageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 293),
//                NSLayoutConstraint(item: mainImageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 375),
//
////                NSLayoutConstraint(item: captionLabel!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 20),
////                NSLayoutConstraint(item: captionLabel!, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 20),
////                NSLayoutConstraint(item: captionLabel!, attribute: .leading, relatedBy: .equal, toItem: mainImageView!, attribute: .trailing, multiplier: 1, constant: 20),
////                NSLayoutConstraint(item: captionLabel!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 20),
//            ])
//        }
        
        
    }
}

//class WebView: UIView {
//    let button
//}
