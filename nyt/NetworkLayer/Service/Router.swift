//
//  Router.swift
//  nyt
//
//  Created by Umer Saleem on 30/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

/// Router class takes generic EndPointType protocol to implement the request.
class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private var task: URLSessionTask?
    
    /// Reqest method build the URL request based on EndPoint. Completional handler provides handling of the request response.
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
            
        do {
            let request = try self.buildRequest(from: route)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }

    /// Private function to build the request using EndPoint and returns URLRequest.
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .requestParameters(let bodyParameters, let urlParamters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParamters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    /// Private function to configure paramters based on body and/or url parameters. URLRequest parameter is passed through reference.
    private func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        
        do  {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoding.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParamterEncoding.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
}
