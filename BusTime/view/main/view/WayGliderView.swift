//
//  WayGliderView.swift
//  BusTime
//
//  Created by greetgo on 8/24/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class WayGliderView: UIView {
    
    // MARK: - Properties
    lazy var fromcityTitle: UILabel = {
        let label = UILabel()
        label.text = "Алматы"
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var waytimeTitle: UILabel = {
        let label = UILabel()
        label.text = "5 ч. 47мин"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 13)
        return label
    }()
    lazy var line = UIView()
    lazy var wayButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "Group 10512"), for: .normal)
        return btn
    }()
    lazy var circleIcon1 = UIImageView(image: #imageLiteral(resourceName: "Group 10517"))
    lazy var parkFrom = CityGliderView(city: "Мерке")
    lazy var circleIcon2 = UIImageView(image: #imageLiteral(resourceName: "Group 10518"))
    lazy var parkTo = CityGliderView(city: "Сарыагаш")
    lazy var circleIcon3 = UIImageView(image: #imageLiteral(resourceName: "Group 10518"))
    lazy var toCityView = ToCityGliderView()
    lazy var stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        line.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        
        addSubviews([fromcityTitle,waytimeTitle,wayButton,line,stack,circleIcon3,toCityView])
        fromcityTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        waytimeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(fromcityTitle.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
        }
        wayButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(line.snp.centerY)
        }
        line.snp.makeConstraints { (make) in
            make.centerY.equalTo(waytimeTitle.snp.centerY)
            make.left.equalTo(waytimeTitle.snp.right).offset(14)
            make.right.equalTo(wayButton.snp.left).offset(-8)
            make.height.equalTo(1)
        }
        stack.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
        }
        circleIcon3.snp.makeConstraints { (make) in
            make.top.equalTo(stack.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(44)
            make.width.equalTo(6)
            make.height.equalTo(30)
        }
        toCityView.snp.makeConstraints { (make) in
            make.top.equalTo(circleIcon3.snp.bottom).offset(4)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
