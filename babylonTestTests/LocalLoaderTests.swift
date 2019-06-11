//
//  LocalLoaderTests.swift
//  babylonTestTests
//
//  Created by Amish Patel on 09/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import XCTest
import CoreData
@testable import babylonTest

class LocalLoaderTests: XCTestCase {
    
    let dataStore = DataStore()
    
    
    override func setUp() {
        setupObjects()
    }
    
    override func tearDown() {
        clearTestData()
    }
    
    func test_hasLocalPosts() {
        let sut = makeSUT()
        let hasPosts = sut.hasLocalPosts()

        XCTAssertTrue(hasPosts)
    }
    
    func test_hasLocalUsers() {
        let sut = makeSUT()
        let hasUsers = sut.hasLocalUsers()
        
        XCTAssertTrue(hasUsers)
    }
    
    func test_hasLocalComments() {
        let sut = makeSUT()
        let hasComments = sut.hasLocalComments()
        
        XCTAssertTrue(hasComments)
    }
    
    func test_loadLocalPost_hasCorrectData() {
        let sut = makeSUT()
        
        let exp = expectation(description: "wait for post to complete loading")
        
        sut.loadLocalPosts { (results) in
            switch results {
            case let .success(posts):
                if let firstPost = posts.first {
                    XCTAssertEqual("some title", firstPost.title)
                    exp.fulfill()
                }
                break
            case let .failure(error):
                XCTFail(error.localizedDescription)
                break
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func test_loadLocalUsers_hasCorrectData() {
        let sut = makeSUT()
        
        let exp = expectation(description: "wait for user to complete loading")
        
        sut.loadLocalUsers { (results) in
            switch results {
            case let .success(users):
                if let firstUser = users.first {
                    XCTAssertEqual("username", firstUser.username)
                    exp.fulfill()
                }
                break
            case let .failure(error):
                XCTFail(error.localizedDescription)
                break
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func test_loadLocalComments_hasCorrectData() {
        let sut = makeSUT()
        
        let exp = expectation(description: "wait for comments to complete loading")
        
        sut.loadLocalComments { (results) in
            switch results {
            case let .success(comments):
                if let firstComment = comments.first {
                    XCTAssertEqual(1, firstComment.id)
                    exp.fulfill()
                }
                break
            case let .failure(error):
                XCTFail(error.localizedDescription)
                break
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    private func setupObjects() {
        
        let posts = [Post(userId: 1, id: 1, title: "some title", body: "some body")]
        let users = [User(id: 1, username: "username")]
        let comments = [Comment(postId: 1, id: 1)]
        
        do {
            try dataStore.saveObjects(objects: posts, keyPath: dataStore.postsKeyString, completion: nil)
            try dataStore.saveObjects(objects: users, keyPath: dataStore.usersKeyString, completion: nil)
            try dataStore.saveObjects(objects: comments, keyPath: dataStore.commentsKeyString, completion: nil)
        }
        catch let error {
            print(error)
        }
    }
    
    private func clearTestData() {
        dataStore.clearData(forKey: dataStore.postsKeyString)
        dataStore.clearData(forKey: dataStore.usersKeyString)
        dataStore.clearData(forKey: dataStore.commentsKeyString)
    }
    
    private func makeSUT() -> LocalLoader {
        let dataStore = DataStore()
        return LocalLoader(dataStore: dataStore)
    }
}




