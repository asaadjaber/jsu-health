import UIKit

class AvailableTimeSlotsCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var item: PlannerItem?
    
    init(navigationController: UINavigationController?,
         item: PlannerItem?) {
        self.navigationController = navigationController
        self.item = item
    }
    
    func start(navigationController: UINavigationController) {
        guard let item = item else { return }
        
        let timeSlotsViewModel: TimeSlotsViewModel
        switch item {
        case .doctor(let doctor):
            guard let timeSlots = doctor.timeSlots else { return }
            timeSlotsViewModel = TimeSlotsViewModel(timeSlots: timeSlots)
            
        case .clinic(let clinic):
            guard let timeSlots = clinic.timeSlots else { return }
            timeSlotsViewModel = TimeSlotsViewModel(timeSlots: timeSlots)
        }
        let viewController = TimeSlotsViewController(timeSlotsViewModel: timeSlotsViewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
}

