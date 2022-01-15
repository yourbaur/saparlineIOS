//
//  ConvenienceTableViewCell.swift
//  BusTime
//
//  Created by greetgo on 9/7/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class ConvenienceTableViewCell: UITableViewCell {

    lazy var itemSelected = false
    
    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Телевизор"
        label.textColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var iconImage = UIImageView(image: #imageLiteral(resourceName: "Frame 36-1"))
    lazy var line = UIView()
    
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        line.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
        
        addSubviews([titleLabel,iconImage,line])
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        iconImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        line.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
