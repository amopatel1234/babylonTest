//
//  AppCoordinator.swift
//  babylonTest
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        runPostCoordinator()
    }
    
    private func runPostCoordinator() {
        let coordinator = PostCoordinator(router: router)
        addChildCoordinator(coordinator: coordinator)
        
        coordinator.start()
    }
}
