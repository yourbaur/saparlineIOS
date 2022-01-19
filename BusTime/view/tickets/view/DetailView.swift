//
//  DetailView.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/16/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class DetailView: UIView {

    lazy var leftTitle: UILabel = {
        let label = UILabel()
        label.text = "Номер авто"
        label.textColor = maincolor.blue//UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var rightTitle: UILabel = {
        let label = UILabel()
        label.text = "А777ААА"
        label.textColor = maincolor.blue
        label.numberOfLines = 0
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()

    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    init(leftTitle: String, rightTitle: String) {
        super.init(frame: .zero)
        
        self.leftTitle.text = leftTitle
        self.rightTitle.text = rightTitle
        
        backgroundColor = .clear
        
        addSubviews([self.rightTitle,self.leftTitle])
        self.rightTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
        self.leftTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }
    }
}

class NewDetailView: UIView {

    lazy var leftTitle: UILabel = {
        let label = UILabel()
        label.text = "Номер авто"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)//UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
//        label.numberOfLines = 0
        return label
    }()
    lazy var rightTitle: UILabel = {
        let label = UILabel()
        label.text = "А777ААА"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.init(name: Font.mullerBold, size: 14)
        return label
    }()

    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    init(leftTitle: String, rightTitle: String) {
        super.init(frame: .zero)
        
        self.leftTitle.text = leftTitle
        self.rightTitle.text = rightTitle
        
        backgroundColor = .clear
        
        addSubviews([self.rightTitle,self.leftTitle])
        self.rightTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(self.leftTitle.snp.right).offset(18)
            make.width.equalTo(200)
            
        }
        self.leftTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(45)
            make.bottom.equalToSuperview()
//            make.right.equalTo(self.snp.centerX).offset(20)
        }
    }
}


class NewDetailButton: UIView {

    lazy var leftTitle: UILabel = {
        let label = UILabel()
        label.text = "Номер авто"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)//UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
//        label.numberOfLines = 0
        return label
    }()
    lazy var rightTitle: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+7707 190 9009", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
//        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 14)
        button.addTarget(self, action: #selector(makeCall), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    init(leftTitle: String, rightTitle: String) {
        super.init(frame: .zero)
        
        self.leftTitle.text = leftTitle
        self.rightTitle.titleLabel?.text = rightTitle
        
        backgroundColor = .clear
        
        addSubviews([self.rightTitle,self.leftTitle])
        self.rightTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(self.leftTitle.snp.right).offset(18)
            make.right.equalToSuperview().offset(-8)
            
        }
        self.leftTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(45)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func makeCall() {
        let number = URL(string: "tel://87071909009")!
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
}
