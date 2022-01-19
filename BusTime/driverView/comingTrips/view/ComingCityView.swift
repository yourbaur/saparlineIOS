//
//  ComingCityView.swift
//  BusTime
//
//  Created by greetgo on 8/27/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class ComingCityView: UIView {
    
    // MARK: - properties
    lazy var fromCityTitle: UILabel = {
        let label = UILabel()
        label.text = "Almaty"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var fromParkTitle: UILabel = {
        let label = UILabel()
        label.text = "Sairan"
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var arrowIcon = UIImageView(image: UIImage(named: "arrowNew"))
    lazy var toCityTitle: UILabel = {
        let label = UILabel()
        label.text = "Taraz"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var toParkTitle: UILabel = {
        let label = UILabel()
        label.text = "Avtovokszal"
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    
    // MARK: - init
    required init?(coder: NSCoder) { fatalError("") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubviews([fromCityTitle,fromParkTitle,arrowIcon,toCityTitle,toParkTitle])
        fromCityTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalTo(arrowIcon.snp.left).offset(-10)
        }
        fromParkTitle.snp.makeConstraints { (make) in
            make.top.equalTo(fromCityTitle.snp.bottom).offset(4)
            make.right.equalTo(arrowIcon.snp.left).offset(-10)
            make.bottom.equalToSuperview()
        }
        arrowIcon.snp.makeConstraints { (make) in
            //make.centerX.equalToSuperview()
            make.centerY.equalTo(fromCityTitle.snp.centerY)
            make.centerX.equalToSuperview().offset(20)
        }
        toCityTitle.snp.makeConstraints { (make) in
            //make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalTo(arrowIcon.snp.right).offset(10)
        }
        toParkTitle.snp.makeConstraints { (make) in
            make.top.equalTo(toCityTitle.snp.bottom).offset(4)
            make.left.equalTo(arrowIcon.snp.right).offset(10)
        }
    }
}
