//
//  Multimedia.swift
//  nyt
//
//  Created by Umer Saleem on 28/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

struct Multimedia: Decodable {
    let url: String?
    let format: String?
    let height: Int?
    let width: Int?
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
}
