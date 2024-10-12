import UIKit

class CalendarHeaderCell: UICollectionReusableView {
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let areaLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with plannerItem: PlannerItem) {
        titleLabel.text = "Date and Time"
        switch plannerItem {
        case .doctor(let doctor):
            nameLabel.text = doctor.name
            areaLabel.text = doctor.practiceArea.rawValue
            imageView.image = UIImage(named: doctor.name)
        case .clinic(let clinic):
            nameLabel.text = clinic.clinicName
            areaLabel.text = "Clinic"
            imageView.image = UIImage(named: clinic.clinicName)
        }
    }
    
    func setUp() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Futura-Medium", size: 32)!
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 27
        imageView.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        areaLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont(name: "Futura-Medium", size: 16.0)!
        nameLabel.textColor = .black
        
        areaLabel.font = UIFont(name: "Futura-Medium", size: 16.0)!
        areaLabel.textColor = .gray
    
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(areaLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            imageView.widthAnchor.constraint(equalToConstant: 54),
            imageView.heightAnchor.constraint(equalToConstant: 54),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 9),
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            
            areaLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 9),
            areaLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2)
        ])
    }
}
