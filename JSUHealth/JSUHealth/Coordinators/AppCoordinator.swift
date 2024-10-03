//
//  AppCoordinator.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 16/09/2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start(navigationController: UINavigationController)
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController?
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(navigationController: UINavigationController) {
        let viewController = HomeViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
}
