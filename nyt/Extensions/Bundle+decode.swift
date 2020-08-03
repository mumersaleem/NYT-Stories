//
//  Bundle+decode.swift
//  nyt
//
//  Created by Umer Saleem on 31/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

/// Extending Bundle class to decode the json file using JSON Decoder.
extension Bundle {
    func jsonFileDecoder<T: Decodable>(_ T: T.Type, from file: String) throws -> T {

        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        do {
            let responseStr: String = try String(contentsOf: url)
            
            guard let data = responseStr.data(using: .utf8, allowLossyConversion: false) else {
                fatalError("Failed to load data from \(file).")
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch {
            throw error
        }
    }
}
