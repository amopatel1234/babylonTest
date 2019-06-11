//
//  LocalLoader.swift
//  babylonTest
//
//  Created by Amish Patel on 11/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

protocol LocalLoadable {
    
    func hasLocalPosts() -> Bool
    func hasLocalUsers() -> Bool
    func hasLocalComments() -> Bool
    func loadLocalPosts(completion: @escaping (Result<[Post], Error>) -> Void)
    func loadLocalUsers(completion: @escaping (Result<[User], Error>) -> Void)
    func loadLocalComments(completion: @escaping (Result<[Comment], Error>) -> Void)
}

final class LocalLoader: LocalLoadable {
    
    private let dataStore: DataStoreable
    
    init(dataStore: DataStoreable) {
        self.dataStore = dataStore
    }
    
    func hasLocalPosts() -> Bool {
        do {
            let post: [Post] = try dataStore.getObject(forKeyPath: dataStore.postsKeyString)
            return post.count > 0 ? true: false
        } catch {
            return false
        }
    }
    
    func hasLocalUsers() -> Bool {
        do {
            let users: [User] = try dataStore.getObject(forKeyPath: dataStore.usersKeyString)
            return users.count > 0 ? true: false
        } catch {
            return false
        }
    }
    
    func hasLocalComments() -> Bool {
        do {
            let comments: [Comment] = try dataStore.getObject(forKeyPath: dataStore.commentsKeyString)
            return comments.count > 0 ? true: false
        } catch {
            return false
        }
    }
    
    func loadLocalPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        do {
            let posts: [Post] = try dataStore.getObject(forKeyPath: dataStore.postsKeyString)
            completion(.success(posts))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func loadLocalUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        do {
            let users: [User] = try dataStore.getObject(forKeyPath: dataStore.usersKeyString)
            completion(.success(users))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func loadLocalComments(completion: @escaping (Result<[Comment], Error>) -> Void) {
        do {
            let comments: [Comment] = try dataStore.getObject(forKeyPath: dataStore.commentsKeyString)
            completion(.success(comments))
        } catch let error {
            completion(.failure(error))
        }
    }
}
