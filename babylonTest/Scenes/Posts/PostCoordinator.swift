//
//  PostCoordinator.swift
//  babylonTest
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import UIKit

protocol PostCoordinatorActions {
    func tappedOnCell(postData: Post, users:[User], comments:[Comment])
    func showErrorAlert(error: Error)
}

final class PostCoordinator: Coordinator, PostCoordinatorActions {
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        showPostViewController()
    }
    
    private func showPostViewController() {
        let dataStore = DataStore()
        let remoteLoader = RemoteLoader(httpClient: URLSessionHTTPClient(), objectMapper: ObjectMapper())
        let localLoader = LocalLoader(dataStore: dataStore)
        let dataLoader = DataLoader(remoteLoader: remoteLoader, localLoader: localLoader, dataStore: dataStore)
        
        let viewModel = PostsViewModel(dataLoader: dataLoader, postCoordinatorActions: self)
        let vc = PostsViewController(viewModel: viewModel)
        vc.title = "Posts"
        router.setRootViewController(viewController: vc, hideBar: false)
    }
    
    func tappedOnCell(postData: Post, users: [User], comments: [Comment]) {
        showDetailsViewController(postData: postData, users: users, comments: comments)
    }
    
    private func showDetailsViewController(postData: Post,users: [User], comments: [Comment]) {
        
        let viewModel = DetailViewModel(postData: postData, users: users, comments: comments)
        let vc = DetailsViewController(viewModel: viewModel)
        vc.title = "Details"
        router.pushViewController(viewController: vc)
    }
    
    func showErrorAlert(error: Error) {
        self.router.showErrorAlert(error: error)
    }
}
