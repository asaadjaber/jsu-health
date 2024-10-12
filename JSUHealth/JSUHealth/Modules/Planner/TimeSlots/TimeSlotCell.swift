import UIKit

class TimeSlotCell: UICollectionViewCell {
    var timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func configureWith(timeSlot: TimeSlot) {
        if let minutes = timeSlot.startDate.minute,
           let hour = timeSlot.startDate.hour {
            timeLabel.text = String(hour) + ":" + String(minutes)
        } else if let hour = timeSlot.startDate.hour {
            timeLabel.text = String(hour) + ":00"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubview(timeLabel)
        contentView.backgroundColor = .yellow
        timeLabel.font = UIFont(name: "FuturaLT", size: 18.0)!
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
