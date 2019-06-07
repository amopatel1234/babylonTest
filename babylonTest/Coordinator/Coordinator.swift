//
//  Coordinator.swift
//  babylonTest
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var childCoordinators: [Coordinator] {get set}
    func addChildCoordinator(coordinator: Coordinator)
    func removeChildCoordinator(coordinator: Coordinator)
    func start()
}

extension Coordinator {
    
    func addChildCoordinator(coordinator: Coordinator) {
        childCoordinators.forEach { (element) in
            if element === coordinator {
                return
            }
        }
        
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        guard childCoordinators.isEmpty == false else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
