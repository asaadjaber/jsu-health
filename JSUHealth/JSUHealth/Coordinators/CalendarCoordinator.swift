import UIKit

class CalendarCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var item: PlannerItem?
    
    init(navigationController: UINavigationController?, item: PlannerItem?) {
        self.navigationController = navigationController
        self.item = item
    }
    
    func start(navigationController: UINavigationController) {
        let calendarViewModel = CalendarViewModel(item: item!)
        let calendarViewController = CalendarViewController(calendarViewModel: calendarViewModel)
        navigationController.pushViewController(calendarViewController, animated: true)
    }
}

