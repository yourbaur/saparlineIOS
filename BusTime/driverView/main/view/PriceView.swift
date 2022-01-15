//
//  PriceView.swift
//  BusTime
//
//  Created by greetgo on 10/22/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class PriceView: UIView {

    // MARK: - Properties
    lazy var leftIcon = UIImageView(image: #imageLiteral(resourceName: "fa-solid_map-pin"))
    lazy var rightIcon = UIImageView(image: #imageLiteral(resourceName: "feather_chevron-right"))
    lazy var field: UITextField = {
        let label = UITextField()
        label.placeholder = "Цена до пункта"
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        label.keyboardType = .numberPad
        return label
    }()
    
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(leftIcon: UIImage, title: String, rightIcon: UIImage) {
        super.init(frame: .zero)
        
        self.leftIcon.image = leftIcon
        self.rightIcon.image = rightIcon
        self.field.placeholder = title
        
        //background
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        layer.cornerRadius = 5
        backgroundColor = .white
        
        //setup
        addSubviews([self.leftIcon, self.rightIcon, self.field])
        self.leftIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(13)
        }
        self.rightIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-13)
            make.width.height.equalTo(20)
        }
        self.field.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.leftIcon.snp.right).offset(16.75)
        }
    }
}
