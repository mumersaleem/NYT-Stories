//
//  Response.swift
//  nyt
//
//  Created by Umer Saleem on 29/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

struct APIResponse: Decodable {
    let status: String?
    let copyright: String?
    let section: String?
    let last_updated: String?
    let num_results: Int?
    let results: [Story]?
}
