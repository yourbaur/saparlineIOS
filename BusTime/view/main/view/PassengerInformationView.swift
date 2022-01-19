//
//  PassengerInformationView.swift
//  SaparLine
//
//  Created by Cheburek on 16.01.2022.
//  Copyright © 2022 thousand.com. All rights reserved.
//

import UIKit

final class PassengerInformationView: UIView {

    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 9
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var placeText: UILabel = {
        let label = UILabel()
        label.text = "Место:"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    
    private lazy var placeTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = maincolor.blue
        label.text = "0"
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    
    private lazy var iinText: UILabel = {
        let label = UILabel()
        label.text = "ИИН:"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    
    private lazy var iinTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = maincolor.blue
        label.text = "990808350043"
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    
    private lazy var nameText: UILabel = {
        let label = UILabel()
        label.text = "Имя:"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    
    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = maincolor.blue
        label.text = "Alisher"
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    
    private lazy var phoneText: UILabel = {
        let label = UILabel()
        label.text = "Телефон:"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    
    private lazy var phoneTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = maincolor.blue
        label.text = "8708234234234"
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    
    lazy var grayView = UIView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        grayView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        mainView.addSubviews([placeText, placeTextLabel,
                             iinText, iinTextLabel,
                             nameText, nameTextLabel,
                             phoneText, phoneTextLabel])
        placeText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(100)
        }
        
        placeTextLabel.snp.makeConstraints {
            $0.left.equalTo(placeText.snp.right).offset(16)
            $0.centerY.equalTo(placeText.snp.centerY)
        }
        
        iinText.snp.makeConstraints {
            $0.top.equalTo(placeText.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(100)
        }
        
        iinTextLabel.snp.makeConstraints {
            $0.left.equalTo(iinText.snp.right).offset(16)
            $0.centerY.equalTo(iinText.snp.centerY)
        }
        
        nameText.snp.makeConstraints {
            $0.top.equalTo(iinText.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(100)
        }
        
        nameTextLabel.snp.makeConstraints {
            $0.left.equalTo(nameText.snp.right).offset(16)
            $0.centerY.equalTo(nameText.snp.centerY)
        }
        
        phoneText.snp.makeConstraints {
            $0.top.equalTo(nameText.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(100)
        }
        
        phoneTextLabel.snp.makeConstraints {
            $0.left.equalTo(phoneText.snp.right).offset(16)
            $0.centerY.equalTo(phoneText.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
