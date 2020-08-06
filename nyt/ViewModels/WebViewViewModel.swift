//
//  MyWebViewViewModel.swift
//  nyt
//
//  Created by Umer Saleem on 04/08/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

class WebViewModel {
    var urlString: String?
}

//MARK:- Load Request based on url string
extension WebViewModel {
    func getURLRequest() -> URLRequest? {
        guard let urlString = urlString, let url = URL(string: urlString) else { return nil}
        return URLRequest(url: url)
    }
}
