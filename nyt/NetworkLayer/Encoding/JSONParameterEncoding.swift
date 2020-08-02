//
//  JSONParameterEncoding.swift
//  nyt
//
//  Created by Umer Saleem on 30/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

struct JSONParameterEncoding: ParameterEncoder, EncodableParamters {
    
    /// Multiple conformances here would provide us with the opportunity to encode paramters via JSON Serialzation or With JSON Encoder
    
    /// Encode paramters with JSON Encoder
        static func encode<T: Encodable>(urlRequest: inout URLRequest, with parameters: T) throws {
         do {
            let encodedData = try JSONEncoder().encode(parameters)
               urlRequest.httpBody = encodedData
               if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                   urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
               }
           } catch {
               throw NetworkError.encodingFailed
           }
    }
    
    
    /// Encode the paramters with JSON Serialization
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
