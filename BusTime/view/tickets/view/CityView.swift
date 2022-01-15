//
//  CityView.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/16/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class CityView: UIView {

    lazy var fromCity: UILabel = {
        let label = UILabel()
        label.text = "Алматы"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var fromPark: UILabel = {
        let label = UILabel()
        label.text = "Сайран"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var toCity: UILabel = {
        let label = UILabel()
        label.text = "Шымкент"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var toPark: UILabel = {
        let label = UILabel()
        label.text = "АвтоШым"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubviews([fromCity,fromPark,toCity,toPark])
        fromCity.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }
        fromPark.snp.makeConstraints { (make) in
            make.top.equalTo(fromCity.snp.bottom).offset(4)
            make.left.equalTo(fromCity.snp.left)
            make.bottom.equalToSuperview()
        }
        toCity.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
        toPark.snp.makeConstraints { (make) in
            make.top.equalTo(toCity.snp.bottom).offset(4)
            make.right.equalTo(toCity.snp.right)
            make.bottom.equalToSuperview()
        }
    }
}
