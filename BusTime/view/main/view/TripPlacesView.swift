//
//  TripPlacesView.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/19/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class TripPlacesView: UIView {

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
    lazy var stateNumber: UILabel = {
        let label = UILabel()
        label.text = "Номер авто:"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var idplace: UILabel = {
        let label = UILabel()
        label.text = "Ваши места:"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var stateNumberTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var idplaceTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var grayView = UIView()
    lazy var icon: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Group-18"))
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = maincolor.blue
        return image
    }()
    lazy var attentionTitle: UILabel = {
        let label = UILabel()
        label.text = "Эти данные нужно ввести в сообщении при переводе денег"
        label.numberOfLines = 2
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
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
        mainView.addSubviews([idplace,idplaceTitle,stateNumber,stateNumberTitle,grayView,icon,attentionTitle])
        idplace.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        idplaceTitle.snp.makeConstraints { (make) in
            make.top.equalTo(idplace.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        stateNumber.snp.makeConstraints { (make) in
            make.top.equalTo(idplaceTitle.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        stateNumberTitle.snp.makeConstraints { (make) in
            make.top.equalTo(stateNumber.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        grayView.snp.makeConstraints { (make) in
            make.top.equalTo(stateNumberTitle.snp.bottom).offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-9)
        }
        icon.snp.makeConstraints { (make) in
            make.centerY.equalTo(grayView)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }
        attentionTitle.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.top)
            make.left.equalTo(icon.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
        }
    }
}

class TripNewPlaceView: UIView {

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
    lazy var stateNumber: UILabel = {
        let label = UILabel()
        label.text = "Номер авто:"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var idplace: UILabel = {
        let label = UILabel()
        label.text = "Места:"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var stateNumberTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var idplaceTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 22)
        return label
    }()
    lazy var grayView = UIView()
    lazy var icon: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Group-18"))
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = maincolor.blue
        return image
    }()
    lazy var attentionTitle: UILabel = {
        let label = UILabel()
        label.text = "Эти данные нужно ввести в сообщении при переводе денег"
        label.numberOfLines = 2
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
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
        mainView.addSubviews([idplace,idplaceTitle])
        idplace.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            
        }
        idplaceTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-62)
            make.centerY.equalToSuperview()
        }
       
    }
}
