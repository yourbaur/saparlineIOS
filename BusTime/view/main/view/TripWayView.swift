//
//  TripWayView.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/19/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class TripWayView: UIView {

    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 9
        view.backgroundColor = .white
        return view
    }()
    lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.text = "24 июля 2020г"
        label.textColor = .gray
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.text = "17:32"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var cityTitle: UILabel = {
        let label = UILabel()
        label.text = "Алматы"
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var parkTitle: UILabel = {
        let label = UILabel()
        label.text = "Сайран автовокзал"
        label.textColor = .gray//UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var totimeTitle: UILabel = {
        let label = UILabel()
        label.text = "17:32"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var tocityTitle: UILabel = {
        let label = UILabel()
        label.text = "Чимкент"
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var toparkTitle: UILabel = {
        let label = UILabel()
        label.text = "Бекжан"
        label.textColor = .gray//UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var toDateTitle: UILabel = {
        let label = UILabel()
        label.text = "24 июля 2020г"
        label.textColor = .gray
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    lazy var arrow = UIImageView(image: #imageLiteral(resourceName: "Group-7"))
    lazy var duration: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .gray
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        mainView.addSubviews([cityTitle,parkTitle,timeTitle,dateTitle,arrow,tocityTitle,toparkTitle,totimeTitle,toDateTitle,duration])
        cityTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        parkTitle.snp.makeConstraints { (make) in
            make.top.equalTo(cityTitle.snp.bottom).offset(4)
            make.centerX.equalTo(cityTitle)
        }
        timeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(parkTitle.snp.bottom).offset(8)
            make.centerX.equalTo(cityTitle)
        }
        dateTitle.snp.makeConstraints { (make) in
            make.top.equalTo(timeTitle.snp.bottom).offset(4)
            make.centerX.equalTo(cityTitle)
            make.bottom.equalToSuperview().offset(-16)
        }
        arrow.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(cityTitle.snp.right)
            make.right.equalTo(tocityTitle.snp.left)
        }
        tocityTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        toparkTitle.snp.makeConstraints { (make) in
            make.top.equalTo(tocityTitle.snp.bottom).offset(4)
            make.centerX.equalTo(tocityTitle)
        }
        totimeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(toparkTitle.snp.bottom).offset(8)
            make.centerX.equalTo(tocityTitle)
        }
        toDateTitle.snp.makeConstraints { (make) in
            make.top.equalTo(totimeTitle.snp.bottom).offset(4)
            make.centerX.equalTo(tocityTitle)
        }
        duration.snp.makeConstraints { (make) in
            make.centerX.equalTo(arrow)
            make.top.equalTo(arrow.snp.bottom).offset(4)
        }
    }
}
class TripNewWayView: UIView {

    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 9
        view.backgroundColor = .white
        return view
    }()
    lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.text = "24 июля 2020г"
        label.textColor = .gray
        label.font = UIFont.init(name: Font.mullerMedium, size: 14)
        return label
    }()
    lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.text = "17:32"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var cityTitle: UILabel = {
        let label = UILabel()
        label.text = "Алматы"
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var parkTitle: UILabel = {
        let label = UILabel()
        label.text = "Сайран автовокзал"
        label.textColor = .gray//UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var totimeTitle: UILabel = {
        let label = UILabel()
        label.text = "17:32"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var tocityTitle: UILabel = {
        let label = UILabel()
        label.text = "Чимкент"
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var toparkTitle: UILabel = {
        let label = UILabel()
        label.text = "Бекжан"
        label.textColor = .gray//UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var toDateTitle: UILabel = {
        let label = UILabel()
        label.text = "24 июля 2020г"
        label.textColor = .gray
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    lazy var arrow = UIImageView(image: UIImage(named: "rect"))
    lazy var duration: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .gray
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        mainView.addSubviews([cityTitle,parkTitle,arrow,tocityTitle,toparkTitle,duration, dateTitle, timeTitle ])
        cityTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        parkTitle.snp.makeConstraints { (make) in
            make.top.equalTo(cityTitle.snp.bottom).offset(4)
            make.centerX.equalTo(cityTitle)
            
        }
        timeTitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(arrow.snp.top).offset(-25)
            make.centerX.equalTo(arrow)
        }
        dateTitle.snp.makeConstraints { (make) in
            make.top.equalTo(timeTitle.snp.bottom).offset(4)
            make.centerX.equalTo(arrow)
        }
        arrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(cityTitle)
            make.left.equalTo(cityTitle.snp.right)
            make.right.equalTo(tocityTitle.snp.left)
        }
        tocityTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-16)
            make.width.equalToSuperview().multipliedBy(0.4)
            
        }
        toparkTitle.snp.makeConstraints { (make) in
            make.top.equalTo(tocityTitle.snp.bottom).offset(4)
            make.centerX.equalTo(tocityTitle)
           
        }
       
        duration.snp.makeConstraints { (make) in
            make.centerX.equalTo(arrow)
            make.top.equalTo(arrow.snp.bottom).offset(4)
        }
    }
}
