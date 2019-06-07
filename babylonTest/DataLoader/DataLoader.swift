//
//  DataLoader.swift
//  babylonTest
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

protocol DataLoadable {
    func loadPosts(fromURL url: URL, completion: @escaping ([Post]) -> Void)
    func loadUsers(fromURL url: URL, completion: @escaping ([User]) -> Void)
    func loadComments(fromURL url: URL, completion: @escaping ([Comment]) -> Void)
}
