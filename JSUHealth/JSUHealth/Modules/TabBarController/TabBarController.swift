//
//  TabBarController.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 28/09/2024.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        configureTabs()
    }
    
    func configureTabs() {
        let viewController = HomeViewController()
        viewController.title = "Clinics"
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        let clinicViewModel = ClinicCardViewModel()
        
        viewController.procedureViewModel = ProcedureCardViewModel()
        viewController.clinicViewModel = clinicViewModel
        
        viewControllers?.append(viewController)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
