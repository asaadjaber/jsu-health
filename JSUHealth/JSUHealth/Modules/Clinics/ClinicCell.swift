//
//  ClinicCell.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 19/09/2024.
//

import Foundation
import UIKit
import SnapKit

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
        
        locationView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(10)
            make.leading.equalTo(contentView).inset(10)
        }
        
        nameLabel.accessibilityIdentifier = "clinic-name-label"
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(10)
            make.top.equalTo(contentView).inset(10)
        }
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
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
