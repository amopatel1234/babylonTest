//
//  DataLoaderTests.swift
//  babylonTestTests
//
//  Created by Amish Patel on 11/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import XCTest
@testable import babylonTest

class DataLoaderTests: XCTestCase {
    
    func test_loadPost_loadsLocalObjects() {
        let sut = makeSUT(shouldLoadLocal: true)
        
        let exp = expectation(description: "loads local posts")
        
        sut.loadPosts { (results) in
            switch results {
            case let .success(posts):
                XCTAssertEqual("Some title", posts[0].title)
                exp.fulfill()
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func test_loadUsers_loadsLocalObjects() {
        let sut = makeSUT(shouldLoadLocal: true)
        
        let exp = expectation(description: "loads local users")
        
        sut.loadUsers { (results) in
            switch results {
            case let .success(users):
                XCTAssertEqual("username", users[0].username)
                exp.fulfill()
                
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func test_loadComments_loadsLocalObjects() {
        let sut = makeSUT(shouldLoadLocal: true)
        
        let exp = expectation(description: "loads local comments")
        
        sut.loadComments { (results) in
            switch results {
            case let .success(comments):
                XCTAssertEqual(1, comments[0].id)
                exp.fulfill()
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func test_loadPost_loadsRemoteObjects() {
        let sut = makeSUT(shouldLoadLocal: false)
        
        let exp = expectation(description: "loads local posts")
        
        sut.loadPosts { (results) in
            switch results {
            case let .success(posts):
                XCTAssertEqual("Some title", posts[0].title)
                exp.fulfill()
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func test_loadUsers_loadsRemoteObjects() {
        let sut = makeSUT(shouldLoadLocal: false)
        
        let exp = expectation(description: "loads local users")
        
        sut.loadUsers { (results) in
            switch results {
            case let .success(users):
                XCTAssertEqual("username", users[0].username)
                exp.fulfill()
                
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func test_loadComments_loadsRemoteObjects() {
        let sut = makeSUT(shouldLoadLocal: false)
        
        let exp = expectation(description: "loads local comments")
        
        sut.loadComments { (results) in
            switch results {
            case let .success(comments):
                XCTAssertEqual(1, comments[0].id)
                exp.fulfill()
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    private func makeSUT(shouldLoadLocal: Bool) -> DataLoader {
        let localLoaderMock = LocalLoaderMock(localLoad: shouldLoadLocal)
        let remoteLoadMock = RemoteLoaderMock()
        let dataStoreMock = DataStoreMock()
        
        let sut = DataLoader(remoteLoader: remoteLoadMock, localLoader: localLoaderMock, dataStore: dataStoreMock)
        return sut
    }
    
}

private class LocalLoaderMock: LocalLoadable {
    
    var shouldLoadLocal: Bool
    
    
    init(localLoad: Bool) {
        self.shouldLoadLocal = localLoad
    }
    
    func hasLocalPosts() -> Bool {
        return shouldLoadLocal
    }
    
    func hasLocalUsers() -> Bool {
        return shouldLoadLocal
    }
    
    func hasLocalComments() -> Bool {
        return shouldLoadLocal
    }
    
    func loadLocalPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let posts = [Post(userId: 1, id: 1, title: "Some title", body: "Some body")]
        completion(.success(posts))
    }
    
    func loadLocalUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let users = [User(id: 1, username: "username")]
        completion(.success(users))
    }
    
    func loadLocalComments(completion: @escaping (Result<[Comment], Error>) -> Void) {
        let comments = [Comment(postId: 1, id: 1)]
        completion(.success(comments))
    }
    
    
}

private class RemoteLoaderMock: RemoteLoadable {
    func loadPosts(fromURL url: URL, completion: @escaping (Result<[Post], Error>) -> Void) {
        let posts = [Post(userId: 1, id: 1, title: "Some title", body: "Some body")]
        completion(.success(posts))
    }
    
    func loadUsers(fromURL url: URL, completion: @escaping (Result<[User], Error>) -> Void) {
        let users = [User(id: 1, username: "username")]
        completion(.success(users))
    }
    
    func loadComments(fromURL url: URL, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let comments = [Comment(postId: 1, id: 1)]
        completion(.success(comments))
    }
}

private class DataStoreMock: DataStoreable {
    var postsKeyString: String = ""
    
    var usersKeyString: String = ""
    
    var commentsKeyString: String = ""
    
    func saveObjects<T>(objects: [T], keyPath: String, completion: (() -> Void)?) throws where T : Decodable, T : Encodable {
        
    }
    
    func getObject<T>(forKeyPath keyPath: String) throws -> [T] where T : Decodable, T : Encodable {
        return [T]()
    }
    
    func clearData(forKey key: String) {
        
    }
    
    
}
