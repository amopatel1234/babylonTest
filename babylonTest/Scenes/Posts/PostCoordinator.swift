//
//  PostCoordinator.swift
//  babylonTest
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import UIKit

final class PostCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        showPostViewController()
    }
    
    private func showPostViewController() {
        let vc = PostsViewController()
        vc.title = "Posts"
        router.setRootViewController(viewController: vc, hideBar: false)
    }
}
