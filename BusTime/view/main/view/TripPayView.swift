//
//  TripPayView.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/19/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class TripPayView: UIView {
    
    lazy var grayView = UIView()
    lazy var icon: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Group-18"))
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = maincolor.blue
        return image
    }()
    lazy var kaspiIcon: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "kaspi 96-96"))
        image.backgroundColor = .white
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    lazy var numberTitle: UILabel = {
        let label = UILabel()
        label.text = "Номер для перевода:"
        label.textColor = maincolor.blue
        label.numberOfLines = 1
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    lazy var number: UILabel = {
        let label = UILabel()
        label.text = "+77077906949"
        label.textColor = maincolor.blue
        label.numberOfLines = 1
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()

    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        grayView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        addSubviews([grayView,icon,kaspiIcon,numberTitle,number])
        
        grayView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(56)
            make.bottom.equalToSuperview()
        }
        numberTitle.snp.makeConstraints { (make) in
            make.top.equalTo(grayView).offset(8)
            make.left.equalToSuperview().offset(42)
            make.right.equalToSuperview().offset(-16)
        }
        number.snp.makeConstraints { (make) in
            make.top.equalTo(numberTitle.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(42)
            make.right.equalToSuperview().offset(-16)
        }
        icon.snp.makeConstraints { (make) in
            make.centerY.equalTo(numberTitle.snp.centerY)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }
        kaspiIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(number.snp.centerY)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }
    }
}

class TripNewPayView: UIView {
    
    
    lazy var kaspiIcon: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "kaspi 96-96"))
        image.backgroundColor = .white
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    lazy var copyIcon: CopyButton = {
        let image = CopyButton()
        image.textString = "+77077906949"
        image.setBackgroundImage(UIImage(named: "copyImage")!, for: .normal)
        return image
    }()
    lazy var numberTitle: UILabel = {
        let label = UILabel()
        label.text = "Номер для перевода:"
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var number: UILabel = {
        let label = UILabel()
        label.text = "+77077906949"
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()

    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        
        
        addSubviews([kaspiIcon,numberTitle,number, copyIcon])
        
        
        numberTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(kaspiIcon.snp.right).offset(5)
            
        }
        number.snp.makeConstraints { (make) in
            make.top.equalTo(numberTitle.snp.bottom).offset(8)
            make.left.equalTo(kaspiIcon.snp.right).offset(5)
            make.bottom.equalToSuperview()
        }
        
        kaspiIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(56)
        }
        copyIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(number.snp.right).offset(35)
            make.right.equalToSuperview()
            make.width.height.equalTo(56)
        }
    }
}

class CopyButton: UIButton {
    var textString = String()
}
