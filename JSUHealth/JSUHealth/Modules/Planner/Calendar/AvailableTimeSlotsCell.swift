import UIKit

class AvailableTimeSlotsCell: UICollectionReusableView {
    var timeSlotsView: UIView!
    var selectTimeSlotLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTimeSlotsView() {
        addSubview(timeSlotsView)
        
        timeSlotsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeSlotsView.topAnchor.constraint(equalTo: topAnchor),
            timeSlotsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            timeSlotsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeSlotsView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
//    func setUp() {
//        addSubview(selectTimeSlotLabel)
//        
//        selectTimeSlotLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        selectTimeSlotLabel.font = UIFont(name: "FuturaLT", size: 18)!
//        selectTimeSlotLabel.textColor = Colors.navyBlue
//        selectTimeSlotLabel.text = "Select Time Slot"
//        
//        NSLayoutConstraint.activate([
//            selectTimeSlotLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            selectTimeSlotLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//        ])
//    }
}
