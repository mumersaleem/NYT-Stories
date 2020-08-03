//
//  DetailViewTest.swift
//  nytTests
//
//  Created by Umer Saleem on 02/08/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import XCTest
@testable import NYT

class DetailViewModelTest: XCTestCase {
    
    var viewModel: DetailViewModel!
    
    override func setUp() {
        viewModel = DetailViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func getOfflineStoriesTest() {
        let storiesPromise = expectation(description: "Stories retrived successfully")
        NetworkManager().getOfflineStories(from: "offline") { [weak self] (stories, error) in
            guard let self = self else { return }
            if let stories = stories {
                self.viewModel.story = stories.first
                storiesPromise.fulfill()
            }
        }
        wait(for: [storiesPromise], timeout: 5)
    }
    
    func getImageTest() {
        let storiesPromise = expectation(description: "image retrived successfully")
        NetworkManager().getImageDataFromURL(from: (self.viewModel.story?.multimedia?.first?.url)!) { data in
            guard let _ = data else { return }
            storiesPromise.fulfill()
        }
        wait(for: [storiesPromise], timeout: 10)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
