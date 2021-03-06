//
//  EndPointType.swift
//  nyt
//
//  Created by Umer Saleem on 29/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

/// EndPointType protocol consists of every element requried to make a successfull network call.
protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
