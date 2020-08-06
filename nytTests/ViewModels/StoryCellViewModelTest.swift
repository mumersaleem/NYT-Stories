//
//  StoriesCellViewModelTest.swift
//  nytTests
//
//  Created by Umer Saleem on 02/08/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import XCTest
@testable import NYT

class StoryCellViewModelTest: XCTestCase {
    
    var viewModel: StoryCellViewModel!
    
    override func setUp() {
        viewModel = StoryCellViewModel()
        getOfflineStories()
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func getOfflineStories() {
        NetworkManager.shared.getOfflineStories(from: "offline") { [weak self] (stories, error) in
            guard let self = self else { return }
            if let stories = stories {
                self.viewModel.story = stories.first
            }
        }
    }
    
    func testObjectsForViews() {
        XCTAssertEqual(viewModel.title, viewModel.story?.title)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

