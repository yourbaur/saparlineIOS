//
//  ImageAddView.swift
//  BusTime
//
//  Created by greetgo on 8/28/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class ImageAddView: UIView {

    // MARK: - properties
    lazy var iconImage = UIImageView(image: #imageLiteral(resourceName: "Group-20"))
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Загрузите фото тех паспорта"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        backgroundColor = .white
        
        addSubviews([iconImage,title])
        iconImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15.5)
            make.centerX.equalToSuperview()
            make.width.equalTo(28)
            make.height.equalTo(21)
        }
        title.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom).offset(15.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-14)
        }
    }
}
