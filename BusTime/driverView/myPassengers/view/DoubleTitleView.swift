//
//  DoubleTitleView.swift
//  BusTime
//
//  Created by greetgo on 8/27/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class DoubleTitleView: UIView {

    // MARK: - properties
    lazy var leftTitle: UILabel = {
        let label = UILabel()
        label.text = "Дата бронирования"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var rightTitle: UILabel = {
        let label = UILabel()
        label.text = "23 июля 2020"
        label.textColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    // MARK: - init
    required init?(coder: NSCoder) {fatalError("")}
    init(_ title1: String, _ title2: String) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        leftTitle.text = title1
        rightTitle.text = title2
        
        addSubviews([leftTitle,rightTitle])
        leftTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        rightTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
    }
}


class PassengersHeaderView: UIView {

    // MARK: - properties
    lazy var leftTitle: UILabel = {
        let label = UILabel()
        label.text = "Место"
        label.textColor = .white
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var rightTitle: UILabel = {
        let label = UILabel()
        label.text = "Пассажир"
        label.textColor =  .white
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    lazy var verticalLine:UIImageView = {
        let line = UIImageView()
        line.image = #imageLiteral(resourceName: "gray-vertical-line")
        return line
    }()
    
    // MARK: - init
    required init?(coder: NSCoder) {fatalError("")}
    init(_ title1: String, _ title2: String) {
        super.init(frame: .zero)
        
        backgroundColor = maincolor.blue
        
        leftTitle.text = title1
        rightTitle.text = title2
        
        addSubviews([leftTitle,rightTitle, verticalLine])
        
        
        verticalLine.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalToSuperview()
            
        }
        leftTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(35)
        }
        rightTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-35)
        }
    }
}
