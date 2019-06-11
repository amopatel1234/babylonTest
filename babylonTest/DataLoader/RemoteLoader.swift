//
//  RemoteLoader.swift
//  babylonTest
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

protocol RemoteLoadable {
    func loadPosts(fromURL url: URL, completion: @escaping (Result<[Post], Error>) -> Void)
    func loadUsers(fromURL url: URL, completion: @escaping (Result<[User], Error>) -> Void)
    func loadComments(fromURL url: URL, completion: @escaping (Result<[Comment], Error>) -> Void)
}

final class RemoteLoader: RemoteLoadable {
    
    let httpClient: HTTPClient
    let objectMapper: ObjectMapable
    
    init(httpClient: HTTPClient, objectMapper: ObjectMapable) {
        self.httpClient = httpClient
        self.objectMapper = objectMapper
    }
    
    func loadPosts(fromURL url: URL, completion: @escaping (Result<[Post], Error>) -> Void) {
        loadData(fromURL: url, completion: completion)
    }
    
    func loadUsers(fromURL url: URL, completion: @escaping (Result<[User], Error>) -> Void) {
        loadData(fromURL: url, completion: completion)
    }
    
    func loadComments(fromURL url: URL, completion: @escaping (Result<[Comment], Error>) -> Void) {
        loadData(fromURL: url, completion: completion)
    }
    
    private func loadData<T: Codable>(fromURL url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
        httpClient.get(url: url) { (result) in
            switch result {
            case let .success(data):
                do {
                    let objets: [T] = try self.objectMapper.mapData(data: data)
                    completion(.success(objets))
                } catch let error {
                    completion(.failure(error))
                }
                break
            case let .failure(error):
                completion(.failure(error))
                break
            }
        }
    }
}
