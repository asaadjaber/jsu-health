import UIKit

class AvailableTimeSlotsCell: UICollectionReusableView {
    var timeSlotsView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        
        addSubview(timeSlotsView)
        
        NSLayoutConstraint.activate([
            timeSlotsView.topAnchor.constraint(equalTo: topAnchor),
            timeSlotsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            timeSlotsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeSlotsView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
