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
    
    @IBOutlet weak var webView: MyWebView!
    lazy var viewModel = DetailViewModel()
    

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .plain, target: self, action: #selector(handleWebView))
    }
}

//MARK:- Binding view model with view
extension DetailViewController {
    func bindViewModel() {
        
        titleLabel.text = viewModel.title
        captionLabel.text = viewModel.caption
        
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

//MARK:- Webview handling to show the story inside webview.
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

//MARK:- Orientation handling for webview
extension DetailViewController {
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        webView.frame = self.view.frame
    }
}
