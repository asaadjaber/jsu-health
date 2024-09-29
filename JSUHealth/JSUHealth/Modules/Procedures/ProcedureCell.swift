//
//  ProcedureCell.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 16/09/2024.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class ProcedureCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    var proceduresLabelCollectionView: UICollectionView!
    var priceTextView: UIView?
    var procedureLabelsView: UIView?
    
    static let reuseIdentifier = "procedure-cell-reuse-identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func setUp(with card: ProcedureCard) {
        
        if priceTextView != nil, let priceTextView = priceTextView {
            contentView.addSubview(priceTextView)
            priceTextView.accessibilityIdentifier = "procedure-card-price-label"
            priceTextView.snp.makeConstraints { make in
                make.top.equalTo(contentView).offset(10)
                make.right.equalTo(contentView).offset(-10)
            }
        }
        
        if let procedureLabelsView = procedureLabelsView {
            contentView.addSubview(procedureLabelsView)
            
            procedureLabelsView.translatesAutoresizingMaskIntoConstraints = false
            
            procedureLabelsView.snp.makeConstraints { make in
                make.leading.equalTo(contentView).offset(10)
                make.bottom.equalTo(contentView).offset(-10)
            }
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension ProcedureCell {
    func configure() {
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        contentView.layer.cornerRadius = 20
        
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
                        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
