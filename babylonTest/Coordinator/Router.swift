//
//  Router.swift
//  babylonTest
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    func setRootViewController(viewController: UIViewController, hideBar: Bool)
    func pushViewController(viewController: UIViewController)
}

final class Router: RouterProtocol {
    
    private weak var rootController: UINavigationController?
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    func setRootViewController(viewController: UIViewController, hideBar: Bool = false) {
        rootController?.setViewControllers([viewController], animated: true)
        rootController?.setNavigationBarHidden(hideBar, animated: true)
    }
    
    func pushViewController(viewController: UIViewController) {
        rootController?.pushViewController(viewController, animated: true)
    }
}

