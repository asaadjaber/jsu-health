import UIKit

class CalendarCell: UICollectionViewCell {
    var calendarView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func configure() {
        contentView.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: contentView.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setUp() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
