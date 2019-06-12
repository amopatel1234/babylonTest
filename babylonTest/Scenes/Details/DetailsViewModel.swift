//
//  DetailsViewModel.swift
//  babylonTest
//
//  Created by Amish Patel on 12/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

final class DetailViewModel {
    private let postData: Post
    private let users: [User]
    private let comments: [Comment]
    
    init(postData: Post, users: [User], comments: [Comment]) {
        self.postData = postData
        self.users = users
        self.comments = comments
    }
    
    func bodtText() -> String {
        return postData.body
    }
    
    func authorOfPost() -> String{
        
        let userId = postData.userId
        
        if let userOfPost = (users.filter { $0.id == userId}).first {
            return "By: \(userOfPost.username)"
        }
        
        return ""
    }
    
    func numberOfComments() -> String {
        
        let postId = postData.id
        
        let numberOfComments = (comments.filter {$0.postId == postId}).count
        
        return "number of comments: \(numberOfComments)"
    }
}
