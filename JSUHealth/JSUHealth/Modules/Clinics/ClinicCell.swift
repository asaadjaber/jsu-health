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
    var locationLabel: UILabel!
    
    static let reuseIdentifier = "clinic-cell-reuse-identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func setUp(with card: ClinicCard) {
        locationLabel.text = "Turkey, \(card.location)"
        locationLabel.accessibilityIdentifier = "clinic-card-location-label"
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension ClinicCell {
    func configure() {
        imageView = UIImageView()
        locationLabel = UILabel()
        
        contentView.addSubview(imageView)
        contentView.addSubview(locationLabel)

        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        let inset = CGFloat(15)
        
        locationLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(inset)
            make.bottom.equalTo(contentView).inset(-inset)
        }
    }
}
