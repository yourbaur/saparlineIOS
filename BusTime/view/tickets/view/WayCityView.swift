//
//  WayCityView.swift
//  BusTime
//
//  Created by greetgo on 8/17/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class WayCityView: UIView {

    lazy var fromTitle: UILabel = {
        let label = UILabel()
        label.text = "Астана"
        label.textColor = .white
        label.font = UIFont.init(name: Font.mullerMedium, size: 20)
        return label
    }()
    lazy var parkfromTitle: UILabel = {
        let label = UILabel()
        label.text = "Сайран"
        label.textColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 14)
        return label
    }()
    lazy var iconView = UIImageView(image: #imageLiteral(resourceName: "Group-10"))
    lazy var toTitle: UILabel = {
        let label = UILabel()
        label.text = "Шымкент"
        label.textColor = .white
        label.font = UIFont.init(name: Font.mullerMedium, size: 20)
        return label
    }()
    lazy var parktoTitle: UILabel = {
        let label = UILabel()
        label.text = "Айна"
        label.textColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 14)
        return label
    }()
    
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews([fromTitle,parkfromTitle,iconView,toTitle,parktoTitle])
        fromTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        parkfromTitle.snp.makeConstraints { (make) in
            make.top.equalTo(fromTitle.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
        }
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(fromTitle.snp.right).offset(14)
        }
        toTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(iconView.snp.right).offset(14)
        }
        parktoTitle.snp.makeConstraints { (make) in
            make.top.equalTo(toTitle.snp.bottom).offset(4)
            make.left.equalTo(iconView.snp.right).offset(14)
        }
    }
}
