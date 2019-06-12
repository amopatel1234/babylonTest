//
//  PostsViewModel.swift
//  babylonTest
//
//  Created by Amish Patel on 12/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

final class PostsViewModel {
    
    var hasLoadedAllData: ((Bool,Bool,Bool) -> Void)?
    
    private var hasPosts = false
    private var hasUsers = false
    private var hasComments = false
    
    private let dataLoader: DataLoadable
    private let coordinatorAction: PostCoordinatorActions
    
    private var posts: [Post] = [Post]()
    private var users: [User] = [User]()
    private var comments: [Comment] = [Comment]()
    
    init(dataLoader: DataLoadable, postCoordinatorActions: PostCoordinatorActions) {
        self.dataLoader = dataLoader
        self.coordinatorAction = postCoordinatorActions
    }
    
    func requestDataLoad() {
        
        dataLoader.loadPosts { (results) in
            switch results {
            case let .success(posts):
                if posts.count > 0 {
                    self.posts.append(contentsOf: posts)
                    self.hasPosts = true
                    self.responseToCallback()
                }
            case let .failure(error):
//                print(error)
                self.showError(error: error)
            }
        }
        
        dataLoader.loadUsers { (results) in
            switch results {
            case let .success(users):
                if users.count > 0 {
                    self.users.append(contentsOf: users)
                    self.hasUsers = true
                    self.responseToCallback()
                }
            case let .failure(error):
//                print(error)
                self.showError(error: error)
            }
        }
        
        dataLoader.loadComments { (results) in
            switch results {
            case let .success(comments):
                if comments.count > 0 {
                    self.comments.append(contentsOf: comments)
                    self.hasComments = true
                    self.responseToCallback()
                }
            case let .failure(error):
//                print(error)
                self.showError(error: error)
            }
        }
    }
    
    private func responseToCallback() {
        self.hasLoadedAllData?(self.hasPosts, self.hasUsers, self.hasComments)
    }
    
    func numberOfRow() -> Int {
        return self.posts.count
    }
    
    func cellViewModel(forIndexRow row: Int) -> PostsCellViewModel {
        
        return PostsCellViewModel(postData: posts[row])
    }
    
    func userTappedOnCell(indexRow: Int) {
        //tell coordinator user tapped on the cell and pass the post object
        
        let postData = self.posts[indexRow]
        
        coordinatorAction.tappedOnCell(postData: postData, users: users, comments: comments)
    }
    
    func showError(error: Error) {
        coordinatorAction.showErrorAlert(error: error)
    }
}
