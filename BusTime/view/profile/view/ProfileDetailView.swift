//
//  ProfileDetailView.swift
//  BusTime
//
//  Created by greetgo on 8/20/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class ProfileDetailView: UIView {

    lazy var iconImage = UIImageView(image: #imageLiteral(resourceName: "pencil"))
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Редактировать"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var arrow = UIImageView(image: #imageLiteral(resourceName: "Group-19"))
    lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = maincolor.blue
        return switcher
    }()
    lazy var rightTitle: UILabel = {
        let label = UILabel()
        label.text = "Русский"
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var button = UIButton()
    lazy var field: UITextField = {
        let field = UITextField()
        field.isHidden = true
        field.tintColor = .white
        return field
    }()
    
    
    // MARK: - Properties
    required init?(coder: NSCoder) {fatalError("")}
    init(iconImage: UIImage, title: String, type: String) {
        super.init(frame: .zero)
        
        self.iconImage.image = iconImage
        self.title.text = title
        
        if type == "arrow" {
            switcher.isHidden = true
            rightTitle.isHidden = true
        }else if type == "switcher" {
            arrow.isHidden = true
            rightTitle.isHidden = true
        }else if type == "title" {
            switcher.isHidden = true
            arrow.isHidden = true
        }
        
        setupViews()
    }
    
    
    // MARK: - Setup
    func setupViews() -> Void {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        layer.cornerRadius = 5
        backgroundColor = .white
        
        addSubviews([iconImage,title,arrow,switcher,rightTitle])
        iconImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(23)
            make.width.height.equalTo(15)
            make.centerY.equalToSuperview()
        }
        title.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(13.67)
            make.centerY.equalToSuperview()
        }
        arrow.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-27.5)
            make.width.equalTo(5)
            make.height.equalTo(10)
        }
        switcher.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-22.5)
            switcher.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }
        rightTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-27.5)
        }
        
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        addSubview(field)
        field.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
