import UIKit

class HeaderCell: UICollectionReusableView {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        titleLabel.text = "Book an appointment"
        subtitleLabel.text = "Choose a doctor or clinic"
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        titleLabel.font = UIFont(name: "Futura-Medium", size: 28)!
        subtitleLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        subtitleLabel.textColor = Colors.navyBlue
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        ])
        
    }
}

