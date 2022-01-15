//
//  TimeView.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/16/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class TimeView: UIView {

    lazy var fromTime: UILabel = {
        let label = UILabel()
        label.text = "17:32"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var fromDate: UILabel = {
        let label = UILabel()
        label.text = "23.07.2020"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var carImage = UIImageView(image: #imageLiteral(resourceName: "Frame 31"))
//    lazy var count: UILabel = {
//        let label = UILabel()
//        label.text = "6 часов пути"
//        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
//        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
//        return label
//    }()
    lazy var toTime: UILabel = {
        let label = UILabel()
        label.text = "18:32"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var toDate: UILabel = {
        let label = UILabel()
        label.text = "24.07.2020"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubviews([fromTime,fromDate,carImage,toTime,toDate])
        fromTime.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(24)
        }
        fromDate.snp.makeConstraints { (make) in
            make.top.equalTo(fromTime.snp.bottom).offset(6)
            make.left.equalTo(fromTime.snp.left)
        }
        carImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(90)
            make.height.equalTo(20)
        }
        toTime.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-24)
        }
        toDate.snp.makeConstraints { (make) in
            make.top.equalTo(toTime.snp.bottom).offset(6)
            make.right.equalTo(toTime.snp.right)
            make.bottom.equalToSuperview()
        }
    }
}
