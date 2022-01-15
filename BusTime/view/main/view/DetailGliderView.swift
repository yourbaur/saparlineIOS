//
//  DetailGliderView.swift
//  BusTime
//
//  Created by greetgo on 8/24/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class DetailGliderView: UIView {

    lazy var firstIcon = UIImageView(image: #imageLiteral(resourceName: "television"))
    lazy var secondIcon = UIImageView(image: #imageLiteral(resourceName: "television"))
    lazy var thirdIcon = UIImageView(image: #imageLiteral(resourceName: "television"))
    
    lazy var firstTitle: UILabel = {
        let label = UILabel()
        label.text = "Телевизор"
        label.textColor = UIColor(red: 0.161, green: 0.243, blue: 0.424, alpha: 0.5)
        label.font = UIFont.init(name: Font.mullerRegular, size: 10)
        return label
    }()
    lazy var secondTitle: UILabel = {
        let label = UILabel()
        label.text = "Телевизор"
        label.textColor = UIColor(red: 0.161, green: 0.243, blue: 0.424, alpha: 0.5)
        label.font = UIFont.init(name: Font.mullerRegular, size: 10)
        return label
    }()
    lazy var thirdTitle: UILabel = {
        let label = UILabel()
        label.text = "Телевизор"
        label.textColor = UIColor(red: 0.161, green: 0.243, blue: 0.424, alpha: 0.5)
        label.font = UIFont.init(name: Font.mullerRegular, size: 10)
        return label
    }()
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 8
        return view
    }()
    lazy var stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var firstCellView = UIView()
    lazy var secondCellView = UIView()
    lazy var thirdCellView = UIView()
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(icon1: UIImage, title1: String, icon2: UIImage, title2: String, icon3: UIImage, title3: String) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        firstIcon.image = icon1
        secondIcon.image = icon2
        thirdIcon.image = icon3
        
        firstTitle.text = title1
        secondTitle.text = title2
        thirdTitle.text = title3
        
        addSubviews([mainView,stack])
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(stack)
        }
        stack.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalTo(65)
            make.centerX.equalToSuperview()
        }
        firstCellView.addSubviews([firstIcon,firstTitle])
        firstIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(14)
            make.width.height.equalTo(27)
        }
        firstTitle.snp.makeConstraints { (make) in
            make.top.equalTo(firstIcon.snp.bottom).offset(4)
            make.centerX.equalTo(firstIcon)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        secondCellView.addSubviews([secondIcon,secondTitle])
        secondIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(14)
            make.width.height.equalTo(27)
        }
        secondTitle.snp.makeConstraints { (make) in
            make.top.equalTo(secondIcon.snp.bottom).offset(4)
            make.centerX.equalTo(secondIcon)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        thirdCellView.addSubviews([thirdIcon,thirdTitle])
        thirdIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(14)
            make.width.height.equalTo(27)
        }
        thirdTitle.snp.makeConstraints { (make) in
            make.top.equalTo(thirdIcon.snp.bottom).offset(4)
            make.centerX.equalTo(thirdIcon)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
    }
}
