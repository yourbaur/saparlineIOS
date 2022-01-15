//
//  DescriptionGliderView.swift
//  BusTime
//
//  Created by greetgo on 8/24/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class DescriptionGliderView: UIView {

    // MARK: - Properties
    lazy var typeTransportTitle: UILabel = {
        let label = UILabel()
        label.text = "Тип транспорта №3"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.text = "17:54"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 20)
        return label
    }()
    lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.text = "24 июля 2020"
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 12)
        return label
    }()
    
    
    // MARK: - init
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubviews([typeTransportTitle, timeTitle, dateTitle])
        typeTransportTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(22)
            make.left.equalToSuperview().offset(16)
        }
        timeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(typeTransportTitle.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
        }
        dateTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeTitle.snp.centerY)
            make.left.equalTo(timeTitle.snp.right).offset(8)
        }
    }
}
