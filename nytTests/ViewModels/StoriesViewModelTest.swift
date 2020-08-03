//
//  StoriesViewModelTest.swift
//  nytTests
//
//  Created by Umer Saleem on 02/08/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import XCTest
@testable import NYT

class StoriesViewModelTest: XCTestCase {
    
    var viewModel: StoriesViewModel!
    
    override func setUp() {
        viewModel = StoriesViewModel()
        viewModel.storyType = .home
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testHomeStories() {
        let storiesPromise = expectation(description: "Stories retrived successfully")
        NetworkManager().getTopStories(type: .home) { [weak self] (stories, error) in
            guard let self = self else { return }
            if let stories = stories {
                self.viewModel.stories.value = stories
                storiesPromise.fulfill()
            }
        }
        wait(for: [storiesPromise], timeout: 10)
    }
    
    func testOfflineStories() {
        let storiesPromise = expectation(description: "Stories retrived successfully")
        NetworkManager().getOfflineStories(from: "offline") { [weak self] (stories, error) in

            guard let self = self else { return }
            if let stories = stories {
                self.viewModel.stories.value = stories
                storiesPromise.fulfill()
            }
        }
        
        wait(for: [storiesPromise], timeout: 10)
    }
    
    func testObjectsForView() {
        XCTAssertEqual(viewModel.numberOfRows, viewModel.stories.value.count)
        XCTAssertEqual(viewModel.titleForHeader, viewModel.storyType?.viewHeaderTitle)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
