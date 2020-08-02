//
//  HTTPTask.swift
//  nyt
//
//  Created by Umer Saleem on 30/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String:String]

enum HTTPTask {
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
}
