import UIKit
 
class PlannerCell: UICollectionViewCell {
    let thumbnailImage = UIImageView()
    let nameLabel = UILabel()
    let areaLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func configure(with plannerItem: PlannerItem) {
        switch plannerItem {
        case .doctor(let doctor):
            nameLabel.text = doctor.name
            areaLabel.text = doctor.practiceArea.rawValue
            thumbnailImage.image = UIImage(named: doctor.name)
        case .clinic(let clinic):
            nameLabel.text = clinic.clinicName
            areaLabel.text = "Clinic"
            thumbnailImage.image = UIImage(named: clinic.clinicName)
        }
    }
    
    func setUp() {
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImage.layer.cornerRadius = 27
        thumbnailImage.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        areaLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont(name: "Futura-Medium", size: 16.0)!
        nameLabel.textColor = .black
        
        areaLabel.font = UIFont(name: "Futura-Medium", size: 16.0)!
        areaLabel.textColor = .gray
        
        contentView.layer.cornerCurve = .continuous
        contentView.layer.cornerRadius = 6
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = CGFloat(0.5)
        contentView.backgroundColor = .white
        
        contentView.addSubview(thumbnailImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(areaLabel)
        
        NSLayoutConstraint.activate([
            thumbnailImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thumbnailImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            thumbnailImage.widthAnchor.constraint(equalToConstant: 54),
            thumbnailImage.heightAnchor.constraint(equalToConstant: 54),
            
            nameLabel.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: 9),
            nameLabel.topAnchor.constraint(equalTo: thumbnailImage.topAnchor),
            
            areaLabel.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: 9),
            areaLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
