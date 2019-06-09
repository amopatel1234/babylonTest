//
//  DataLoaderTests.swift
//  babylonTestTests
//
//  Created by Amish Patel on 09/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import XCTest
@testable import babylonTest

class DataLoaderTests: XCTestCase {
    
    func test_loadPost() {
        let sut = makeSUT(withData: makePostJSONData())
        
        let exp = expectation(description: "Wait for data to load")
        
        sut.loadPosts(fromURL: makeAnyURL()) { (result) in
            switch result {
            case let .success(posts):
                if let firstPost = posts.first {
                    XCTAssertEqual(firstPost.id, 1)
                    exp.fulfill()
                } else {
                    XCTFail("Array is empty")
                }
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_loadUser() {
        let sut = makeSUT(withData: makeUserJSONData())
        
        let exp = expectation(description: "Wait for data to load")
        
        sut.loadUsers(fromURL: makeAnyURL()) { (result) in
            switch result {
            case let .success(users):
                if let firstUser = users.first {
                    XCTAssertEqual(firstUser.username, "Bret")
                    exp.fulfill()
                } else {
                    XCTFail("Array is empty")
                }
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_loadComment() {
        let sut = makeSUT(withData: makeCommentJSONData())
        
        let exp = expectation(description: "Wait for data to load")
        
        sut.loadComments(fromURL: makeAnyURL()) { (result) in
            switch result {
            case let .success(comments):
                if let firstComment = comments.first {
                    XCTAssertEqual(firstComment.postId, 1)
                    exp.fulfill()
                } else {
                    XCTFail("Array is empty")
                }
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    private func makeSUT(withData data: Data, error: Error? = nil) -> DataLoader {
        let client = HTTPClientStub(data: data, error: error)
        let mapper = ObjectMapper()
        return DataLoader(httpClient: client, objectMapper: mapper)
    }
    
    private func makePostJSONData() -> Data {
        let jsonString = """
            [{
            "userId": 1,
            "id": 1,
            "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto"
            }]
            """
        
        return Data(jsonString.utf8)
    }
    
    private func makeUserJSONData() -> Data {
        let jsonString = """
[{"id":1,"name":"Leanne Graham","username":"Bret","email":"Sincere@april.biz","address":{"street":"Kulas Light","suite":"Apt. 556","city":"Gwenborough","zipcode":"92998-3874","geo":{"lat":"-37.3159","lng":"81.1496"}},"phone":"1-770-736-8031 x56442","website":"hildegard.org","company":{"name":"Romaguera-Crona","catchPhrase":"Multi-layered client-server neural-net","bs":"harness real-time e-markets"}}]
"""
        return Data(jsonString.utf8)
    }
    
    private func makeCommentJSONData() -> Data {
        let jsonString = """
[{
    "postId": 1,
    "id": 1,
    "name": "id labore ex et quam laborum",
    "email": "Eliseo@gardner.biz",
    "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\\ntempora quo necessitatibus\\ndolor quam autem quasi\\nreiciendis et nam sapiente accusantium"
}]
"""
        return Data(jsonString.utf8)
    }
    
    private func makeAnyURL() -> URL {
        return URL(string: "http://anyurl.com")!
    }
}

private class HTTPClientStub: HTTPClient {
    
    private let data: Data?
    private let error: Error?
    
    init(data: Data?, error: Error? = nil) {
        self.data = data
        self.error = error
    }
    
    func get(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        if let error = error {
            completion(.failure(error))
        } else if let data = data {
            completion(.success(data))
        }
        
    }
    
    
}

