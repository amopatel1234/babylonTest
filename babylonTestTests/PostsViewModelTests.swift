//
//  PostsViewModelTests.swift
//  babylonTestTests
//
//  Created by Amish Patel on 12/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import XCTest
@testable import babylonTest

class PostViewModelTests: XCTestCase {
    
    func test_requestDataLoad_hasLoadedAllData() {
        
        let sut = makeSUT()
        
        
        let exp = expectation(description: "When requesting load has loaded all data")
        sut.hasLoadedAllData = { (hasPost, hasUsers, hasComments) in
            if hasPost && hasUsers && hasComments {
                exp.fulfill()
            }
        }
        
        sut.requestDataLoad()
        
        wait(for: [exp], timeout: 5)
    }
    
    func test_numberOfRow_hasCountOfOne() {
        let sut = makeSUT()
        
        let exp = expectation(description: "wait for data to load")
        sut.hasLoadedAllData = { (hasPost, hasUsers, hasComments) in
            if hasPost && hasUsers && hasComments {
                XCTAssertEqual(sut.numberOfRow(), 1)
                exp.fulfill()
            }
        }
        
        sut.requestDataLoad()
        wait(for: [exp], timeout: 5)
    }
    
    private func makeSUT() -> PostsViewModel {
        return PostsViewModel(dataLoader: DataLoaderMock(), postCoordinatorActions: PostCoordinatorActionsMock())
    }
}

private class DataLoaderMock: DataLoadable {
    func loadPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        completion(.success([Post(userId: 1, id: 1, title: "Some title", body: "Some body")]))
    }
    
    func loadUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        completion(.success([User(id: 1, username: "username")]))
    }
    
    func loadComments(completion: @escaping (Result<[Comment], Error>) -> Void) {
        completion(.success([Comment(postId: 1, id: 1)]))
    }
    
    
}

private class PostCoordinatorActionsMock: PostCoordinatorActions {
    func tappedOnCell(postData: Post, users: [User], comments: [Comment]) {}
    
    func showErrorAlert(error: Error) {}
}
