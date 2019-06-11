//
//  DataLoader.swift
//  babylonTest
//
//  Created by Amish Patel on 11/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

protocol DataLoadable {
    
    func loadPosts(completion: @escaping (Result<[Post], Error>) -> Void)
    func loadUsers(completion: @escaping (Result<[User], Error>) -> Void)
    func loadComments(completion: @escaping (Result<[Comment], Error>) -> Void)
}

final class DataLoader: DataLoadable {
    
    private let remoteLoader: RemoteLoadable
    private let localLoader: LocalLoadable
    private let dataStore: DataStoreable
    
    init(remoteLoader: RemoteLoadable, localLoader: LocalLoadable, dataStore: DataStoreable) {
        self.remoteLoader = remoteLoader
        self.localLoader = localLoader
        self.dataStore = dataStore
        
    }
    
    func loadPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        
        if localLoader.hasLocalPosts() {
            localLoader.loadLocalPosts(completion: completion)
        } else {
            remoteLoader.loadPosts(fromURL: URL(string: "http://jsonplaceholder.typicode.com/posts")!) { (results) in
                switch results {
                case let .success(posts):
                    do {
                        try self.dataStore.saveObjects(objects: posts, keyPath: self.dataStore.postsKeyString, completion: nil)
                    } catch let error {
                        completion(.failure(error))
                    }
                    completion(.success(posts))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loadUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        if localLoader.hasLocalUsers() {
            localLoader.loadLocalUsers(completion: completion)
        } else {
            remoteLoader.loadUsers(fromURL: URL(string: "http://jsonplaceholder.typicode.com/users")!) { (results ) in
                switch results {
                case let .success(users):
                    do {
                        try self.dataStore.saveObjects(objects: users, keyPath: self.dataStore.usersKeyString, completion: nil)
                    } catch let error {
                        completion(.failure(error))
                    }
                    completion(.success(users))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loadComments(completion: @escaping (Result<[Comment], Error>) -> Void) {
        if localLoader.hasLocalComments() {
            localLoader.loadLocalComments(completion: completion)
        } else {
            remoteLoader.loadComments(fromURL: URL(string: "http://jsonplaceholder.typicode.com/comments")!) { (results) in
                switch results {
                case let .success(comments):
                    do {
                        try self.dataStore.saveObjects(objects: comments, keyPath: self.dataStore.commentsKeyString, completion: nil)
                    } catch let error {
                        completion(.failure(error))
                    }
                    completion(.success(comments))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
