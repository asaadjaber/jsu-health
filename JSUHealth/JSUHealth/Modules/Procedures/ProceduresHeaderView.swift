//
//  ProceduresHeaderView.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 23/09/2024.
//

import Foundation
import UIKit
//import SnapKit

class ProceduresHeaderView: UICollectionReusableView {
    let label = UILabel()
    let border = UIView()
    var sectionIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(with title: String) {
        self.label.text = title
        guard let gothamBold = UIFont(name: "GothamRounded-Bold", size: UIFont.labelFontSize) else {
            fatalError("Failed to load Gotham Rounded Bold font.")
        }
        label.font = gothamBold
        
        if sectionIndex == 0 {
            self.border.isHidden = true
        }
    }
}

extension ProceduresHeaderView {
    
    func configureView() {
        label.translatesAutoresizingMaskIntoConstraints = false
       
        self.addSubview(label)
        self.addSubview(border)
        
        border.backgroundColor = .black
        
        self.addSubview(label)
           
        border.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            border.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            border.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            border.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            border.heightAnchor.constraint(equalToConstant: 1)
        ])
        
//        label.snp.makeConstraints { make in
//            make.leading.equalTo(self).inset(10)
//            make.centerY.equalTo(self)
//        }
        
//        border.snp.makeConstraints { make in
//            make.leading.equalTo(self).inset(3)
//            make.width.equalTo(UIScreen.main.bounds.width)
//            make.top.equalTo(self).inset(10)
//            make.height.equalTo(1)
//        }
    }
}
