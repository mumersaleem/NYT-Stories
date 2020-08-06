//
//  MyWebView.swift
//  nyt
//
//  Created by Umer Saleem on 03/08/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let webView = WKWebView()
    var viewModel = WebViewModel()
    
    /// Update the frame after chaning orientation
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        webView.frame = view.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = view.frame
        webView.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view.addSubview(webView)
        loadRequest()
    }
}

//MARK:- Load the urlRequest or show Error alert if failed
extension WebViewController {
    private func loadRequest() {
        if let request = viewModel.getURLRequest() {
            webView.load(request)
        }
    }
}

//MARK:- WebView delegate methods
extension WebViewController: WKNavigationDelegate, AlertPresentable {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        presentAlert(title: "Error", message: "Story could not be loaded", completion: nil)
    }
}
