//
//  AddImageView.swift
//  BusTime
//
//  Created by greetgo on 9/7/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class AddImageView: UIView {
    
    // MARK: - Properties
    lazy var cameraImage = UIImageView(image: #imageLiteral(resourceName: "Group-20"))
    lazy var cameraImage1 = UIImageView(image: #imageLiteral(resourceName: "Group 10484"))
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузите фото тех паспорта"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(title: String) {
        super.init(frame: .zero)
        
        self.titleLabel.text = title
        self.cameraImage1.isHidden = true   
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        layer.cornerRadius = 6
        backgroundColor = .white
        
        addSubviews([cameraImage, cameraImage1, titleLabel])
        cameraImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15.5)
            make.centerX.equalToSuperview().offset(-10)
            make.width.equalTo(28)
            make.height.equalTo(21)
        }
        
        cameraImage1.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15.5)
            make.left.equalTo(cameraImage.snp.right).offset(5)
            make.width.equalTo(28)
            make.height.equalTo(21)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cameraImage.snp.bottom).offset(15.5)
            make.centerX.equalToSuperview()
        }
    }
}
class AddBusImageView: UIView {
    
    // MARK: - Properties
    lazy var cameraImage = UIImageView(image: #imageLiteral(resourceName: "Group-20"))
    lazy var cameraImage1 = UIImageView(image: #imageLiteral(resourceName: "Group 10484"))
    lazy var cameraImage2 = UIImageView(image: #imageLiteral(resourceName: "Group 10484"))
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузите фото тех паспорта"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(title: String) {
        super.init(frame: .zero)
        
        self.titleLabel.text = title
        self.cameraImage1.isHidden = true
        self.cameraImage2.isHidden = true
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        layer.cornerRadius = 6
        backgroundColor = .white
        
        addSubviews([cameraImage, cameraImage1, cameraImage2, titleLabel])
        cameraImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15.5)
            make.centerX.equalToSuperview().offset(-10)
            make.width.equalTo(28)
            make.height.equalTo(21)
        }
        
        cameraImage1.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15.5)
            make.left.equalTo(cameraImage.snp.right).offset(5)
            make.width.equalTo(28)
            make.height.equalTo(21)
        }
        cameraImage2.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15.5)
            make.left.equalTo(cameraImage1.snp.right).offset(5)
            make.width.equalTo(28)
            make.height.equalTo(21)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cameraImage.snp.bottom).offset(15.5)
            make.centerX.equalToSuperview()
        }
    }
}
