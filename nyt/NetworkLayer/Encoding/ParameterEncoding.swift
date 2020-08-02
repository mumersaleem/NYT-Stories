//
//  ParameterEncoding.swift
//  nyt
//
//  Created by Umer Saleem on 30/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

protocol EncodableParamters {
    static func encode<T: Encodable>(urlRequest: inout URLRequest, with parameters: T) throws
}

enum NetworkError: String, Error {
    case parametersNil = "Parameters are nil"
    case encodingFailed = "Paramteres encoding Failed"
    case missingURL = "URL is nil"
}
