//
//  CustomDriverView.swift
//  BusTime
//
//  Created by greetgo on 8/26/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class CustomDriverView: UIView {

    // MARK: - Properties
    lazy var leftIcon = UIImageView(image: #imageLiteral(resourceName: "fa-solid_map-pin"))
    lazy var rightIcon = UIImageView(image: #imageLiteral(resourceName: "feather_chevron-right"))
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = localized(text: "park")
        label.textColor = maincolor.blue//UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var button = UIButton()
    
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(leftIcon: UIImage, title: String, rightIcon: UIImage) {
        super.init(frame: .zero)
        
        self.leftIcon.image = leftIcon
        self.leftIcon.contentMode = .scaleAspectFit
        self.rightIcon.image = rightIcon
        self.title.text = title
        
        //background
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        layer.cornerRadius = 5
        backgroundColor = .white
        
        //setup
        addSubviews([self.leftIcon, self.rightIcon, self.title,button])
        self.leftIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.width.height.equalTo(20)
        }
        self.rightIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.width.height.equalTo(20)
        }
        self.title.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.leftIcon.snp.right).offset(20)
            make.right.equalTo(self.rightIcon.snp.left).offset(-8)
        }
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
