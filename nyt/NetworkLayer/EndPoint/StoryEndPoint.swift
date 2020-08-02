//
//  StoryEndPoint.swift
//  nyt
//
//  Created by Umer Saleem on 30/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case development
    case staging
    case production
    
    var url: String {
        switch self {
        case .development:
            return "localhost"
        case .staging:
            return "staging"
        case .production:
            return "https://api.nytimes.com/svc/topstories/v2/"
        }
    }
}

enum StoryAPI {
    case home
    case health
    case sports
    case offline
}

extension StoryAPI: EndPointType {
        
    var environmentURL : String {
        NetworkManager.environment.url
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentURL) else { fatalError("Base URL could not be configured")}
        return url
    }
    
    var path: String {
        switch self {
        case .home:
            return "home.json"
        case .sports:
            return "sports.json"
        case .health:
            return "health.json"
        default: return "offline"
        }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var task: HTTPTask {
        return .requestParameters(bodyParameters: nil, urlParameters: ["api-key": NetworkManager.NYTAPIKey])
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
}
