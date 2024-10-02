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
        self.tabBar.backgroundColor = .white
        
        let tabBarItem = UITabBarItem(title: "Clinics", image: UIImage(named: "medical-clinic")!, tag: 0)

        viewController.tabBarItem = tabBarItem

        let clinicViewModel = ClinicCardViewModel()
        tabBar.isTranslucent = false
        tabBar.tintColor = Colors.navyBlue
        tabBar.unselectedItemTintColor = .gray
        
        viewController.procedureViewModel = ProcedureCardViewModel()
        viewController.clinicViewModel = clinicViewModel
        
        let doctorClinicViewModel = DoctorClinicViewModel()
        let plannerViewController = PlannerViewController(doctorClinicViewModel: doctorClinicViewModel)
        
        let plannerTabBarItem = UITabBarItem(title: "Planner", image: UIImage(named: "planner-icon")!, tag: 1)
        plannerViewController.tabBarItem = plannerTabBarItem
        
        self.setViewControllers([viewController, plannerViewController], animated: true)
        viewControllers?.removeAll()
        viewControllers?.insert(viewController, at: 0)
        viewControllers?.insert(plannerViewController, at: 1)

        self.selectedViewController = viewController
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
