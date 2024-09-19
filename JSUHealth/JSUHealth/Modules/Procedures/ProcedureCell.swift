//
//  ProcedureCell.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 16/09/2024.
//

import Foundation
import UIKit
import SnapKit

class ProcedureCell: UICollectionViewCell {
    let priceLabel = UILabel()
    let imageView = UIImageView()
    var proceduresLabelCollectionView: UICollectionView!
    
    static let reuseIdentifier = "procedure-cell-reuse-identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func setUp(with card: ProcedureCard) {
        priceLabel.text = "From $\(card.price)"
        priceLabel.accessibilityIdentifier = "procedure-card-price-label"
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension ProcedureCell {
    func configure() {
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        contentView.addSubview(priceLabel)
        contentView.layer.cornerRadius = 20
        
        priceLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        let inset = CGFloat(10)
        
        NSLayoutConstraint.activate([
            
        ])
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(inset)
            make.right.equalTo(contentView).offset(-inset)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
