//
//  MyPassengersTableViewCell.swift
//  BusTime
//
//  Created by greetgo on 8/27/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class MyPassengersTableViewCell: UITableViewCell {

    // MARK: - Properties
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 6
        return view
    }()
  
//    lazy var dateView = DoubleTitleView("Дата бронирования", "23 июля 2020")
    //lazy var numberTravelView = DoubleTitleView("Номер поездки", "№1234567")
    lazy var numberPlaceView = DoubleTitleView("Num местa", "03")
    lazy var numberTel = DoubleTitleView("Tel", "8777...")
    
    lazy var leftTitle: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.cornerRadius = 8
        label.text = "Новинка"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerBold, size: 14)
        label.backgroundColor = #colorLiteral(red: 0.2567508221, green: 0.3758182824, blue: 0.6300528646, alpha: 1)
        return label
    }()
    lazy var leftTitle1: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.cornerRadius = 8
        label.text = "2"
        label.isHidden = true
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerBold, size: 14)
        label.backgroundColor = #colorLiteral(red: 0.2567508221, green: 0.3758182824, blue: 0.6300528646, alpha: 1)
        return label
    }()
    lazy var leftTitle2: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.cornerRadius = 8
        label.text = "3"
        label.isHidden = true
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerBold, size: 14)
        label.backgroundColor = #colorLiteral(red: 0.2567508221, green: 0.3758182824, blue: 0.6300528646, alpha: 1)
        return label
    }()
    
    lazy var leftTitle3: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.cornerRadius = 8
        label.text = "4"
        label.isHidden = true
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerBold, size: 14)
        label.backgroundColor = #colorLiteral(red: 0.2567508221, green: 0.3758182824, blue: 0.6300528646, alpha: 1)
        return label
    }()
    lazy var callButton:PhoneButton = {
        let button = PhoneButton()
        button.setBackgroundImage(UIImage(named:"callb"), for: .normal)
        return button
    }()
    
    lazy var rightTitle: UILabel = {
        let label = UILabel()
        label.text = "23 июля 2020"
        label.textColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {fatalError("")}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }

    // MARK: - Setup
    func setupViews() -> Void {
        backgroundColor = .white
        contentView.isUserInteractionEnabled  = false
//        priceView.rightTitle.textColor = UIColor(red: 0.184, green: 0.502, blue: 0.929, alpha: 1)
//        priceView.rightTitle.font = UIFont.init(name: Font.mullerMedium, size: 16)
//        
        addSubviews([mainView])
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        mainView.addSubviews([ leftTitle, leftTitle1, leftTitle2, leftTitle3, rightTitle, callButton])
       
//        dateView.snp.makeConstraints { (make) in
//            make.top.equalTo(nameTitle.snp.bottom).offset(14)
//            make.width.equalToSuperview()
//            make.height.equalTo(20)
//        }
        
        leftTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(30)
            make.bottom.equalToSuperview().offset(-10)
        }
        leftTitle1.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(30)
            make.left.equalTo(leftTitle.snp.right).offset(4)
            make.width.equalTo(30)
            make.bottom.equalToSuperview().offset(-10)
        }
        leftTitle2.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(30)
            make.left.equalTo(leftTitle1.snp.right).offset(4)
            make.width.equalTo(30)
            make.bottom.equalToSuperview().offset(-10)
        }
        leftTitle3.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(30)
            make.left.equalTo(leftTitle2.snp.right).offset(4)
            make.width.equalTo(30)
            make.bottom.equalToSuperview().offset(-10)
        }
        rightTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)

            make.height.equalTo(30)
            make.right.equalTo(callButton.snp.left).offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        callButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
       
       
    }
}
