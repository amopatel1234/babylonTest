//
//  PostCellViewModelTests.swift
//  babylonTestTests
//
//  Created by Amish Patel on 13/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import XCTest
@testable import babylonTest

class PostCellViewModelTests: XCTestCase {
    
    func test_getTitle_hasTitle() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.getTitle(), "Some title")
    }
    
    private func makeSUT() -> PostsCellViewModel {
        let post = Post(userId: 1, id: 1, title: "Some title", body: "Some body")
        return PostsCellViewModel(postData: post)
    }
}
