//
//  AppConstants.swift
//  nyt
//
//  Created by Umer Saleem on 28/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

enum NYTApiKey {
    static let apiKey = "4AeIJGh8yV4tT5KIIVWXvqDdJM92okW9"
}

enum CellIdentifiers {
    static let storyCellIdentifier  = "storyCellIdentifier"
    static let detailCellIdentifier = "detailCellIdentifier"
}

enum SegueIdentifiers {
    static let main                     = "Main"
    static let storiesViewController    = "storiesViewController"
    static let detailViewController     = "detailViewController"
}

enum MultimediaImageTypes {
    static let superJumbo           = "superJumbo"
    static let thumbnail            = "Standard Thumbnail"
    static let largeThumbnail       = "thumbLarge"
    static let normal               = "normal"
    static let mediumThreeByTwo210  = "mediumThreeByTwo210"
}
