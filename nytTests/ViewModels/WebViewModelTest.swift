//
//  WebViewModelTest.swift
//  nytTests
//
//  Created by Umer Saleem on 05/08/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import XCTest
@testable import NYT

class WebViewModelTest: XCTestCase {
    
    var viewModel: WebViewModel!
    
    override func setUp() {
        viewModel = WebViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testLoadRequest() {
        viewModel.urlString = "https://www.google.com"
        
        let requestPromise = expectation(description: "URL Request successful")
        if let _ = viewModel.getURLRequest() {
            requestPromise.fulfill()   
        }
        wait(for: [requestPromise], timeout: 2)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
