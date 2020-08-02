//
//  NetworkManager.swift
//  nyt
//
//  Created by Umer Saleem on 30/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "Authentication Failed"
    case badRequest = "Bad Request"
    case failed = "Network Request Failed"
    case outDatedURL = "Request URL is no longer valid"
    case unableToDecode = "Unable to decode the response"
    case noData = "Response contains no data"
}

enum Result<String> {
    case success
    case failure(String)
}

struct NetworkManager {
    
    static let environment: NetworkEnvironment = .production
    static let NYTAPIKey = NYTApiKey.apiKey
    private let router = Router<StoryAPI>()
    
    /// Get top stories based on the type of Story
    func getTopStories(type: StoryAPI, completion: @escaping (_ stories: [Story]?, _ error: String?) -> () ) {
        
        router.request(type) { (data, response, error) in
            
            if error != nil {
                return completion(nil, "network connection failed")
            }            
            
            guard let response = response as? HTTPURLResponse else { return print("url response error")}
            
            let result = self.handleNetworkResponse(response)
            
            switch result {
            case.success:
                
                guard let data = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
//                    NetworkLogger.log(response: apiResponse)
                    completion(apiResponse.results, nil)
                    
                } catch {
                    print(error)
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError): completion(nil, networkFailureError)
            }
        }
    }
    
    func getOfflineStories(from file: String, completion: @escaping(_ stories: [Story]?, _ error: String?) -> ()) {
        do {
            let response: APIResponse = try Bundle.main.jsonFileDecoder(APIResponse.self, from: file)
            completion(response.results, nil)
        } catch {
            completion(nil, error.localizedDescription)
        }
    }
    
    func getImageDataFromURL(from url: String, completion: @escaping(Data?) -> ()) {
        guard let url = URL(string: url) else { return completion(nil) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return completion(nil)}
            completion(data)
        }.resume()
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...599: return .failure(NetworkResponse.authenticationError.rawValue)
        case 401...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outDatedURL.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
