//
//  Story.swift
//  nyt
//
//  Created by Umer Saleem on 28/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

struct Story: Decodable {
    
    let section: String?
    let subsection: String?
    let title: String?
    let abstract: String?
    let url: String?
    let publishedDate: String?
    let multimedia: [Multimedia]?
    
}
