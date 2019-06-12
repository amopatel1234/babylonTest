//
//  PostsCellViewModel.swift
//  babylonTest
//
//  Created by Amish Patel on 12/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

final class PostsCellViewModel {
    
    private let postData: Post
    
    init(postData: Post) {
        self.postData = postData
    }
    
    func getTitle() -> String {
        return postData.title
    }
}
