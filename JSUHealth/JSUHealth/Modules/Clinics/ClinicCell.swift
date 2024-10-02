//
//  ClinicCell.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 19/09/2024.
//

import Foundation
import UIKit
//import SnapKit

class ClinicCell: UICollectionViewCell {
    var imageView: UIImageView!
    var locationView: UIView!
    var nameLabel: UIView!
    
    static let reuseIdentifier = "clinic-cell-reuse-identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func setUp(with card: ClinicCard) {
        locationView.accessibilityIdentifier = "clinic-card-location-label"
        
        contentView.addSubview(locationView)
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.accessibilityIdentifier = "clinic-name-label"
        locationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            locationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
//        locationView.snp.makeConstraints { make in
//            make.bottom.equalTo(contentView).inset(10)
//            make.leading.equalTo(contentView).inset(10)
//        }
        
//        nameLabel.snp.makeConstraints { make in
//            make.leading.equalTo(contentView).inset(10)
//            make.top.equalTo(contentView).inset(10)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension ClinicCell {
    func configure() {
        imageView = UIImageView()
        
        contentView.addSubview(imageView)

        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
   
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
//        imageView.snp.makeConstraints { make in
//            make.edges.equalTo(contentView)
//        }
    }
}
