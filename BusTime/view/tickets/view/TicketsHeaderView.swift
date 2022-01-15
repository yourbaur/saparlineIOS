//
//  TicketsHeaderView.swift
//  BusTime
//
//  Created by greetgo on 8/17/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class TicketsHeaderView: UIView {

    lazy var iconView = UIImageView(image: #imageLiteral(resourceName: "Group-8"))
    lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Указанный код на билете необходимо показать водителю!"
        label.textColor = UIColor(red: 0.161, green: 0.243, blue: 0.424, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 12)
        label.textAlignment = .left
        return label
    }()
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        
        addSubviews([iconView,title])
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }
        title.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.top)
            make.left.equalTo(iconView.snp.right).offset(4)
            make.right.equalToSuperview().offset(-40)
        }
    }
}
