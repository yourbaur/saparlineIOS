//
//  ComingTripsTableViewCell.swift
//  BusTime
//
//  Created by greetgo on 8/27/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class ComingTripsTableViewCell: UITableViewCell {

    // MARK: - Properties
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor//UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 20
        view.layer.cornerRadius = 20
        return view
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.cornerRadius = 7
        label.text = "Стоимость 3500-6000"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerMedium, size: 15)
        label.backgroundColor = #colorLiteral(red: 0.9057930112, green: 0.905945003, blue: 0.9057729244, alpha: 1)
        return label
    }()
    
    lazy var freeLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.01465321891, green: 0.8041732311, blue: 0.5670229793, alpha: 1)
        label.text = "Свободно: 15"
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerMedium, size: 15)
        return label
    }()
    
    lazy var busyLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.7874272466, green: 0.0006889323704, blue: 0, alpha: 1)
        label.text = "Занято: 15"
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerMedium, size: 15)
        return label
    }()
    
    lazy var typeCarTitle: UILabel = {
        let label = UILabel()
        label.text = "Тип транспорта №1"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    
    lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.text = "24 июля 2020г / 14:30 "
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.init(name: Font.mullerBold, size: 18)
        return label
    }()
    
    lazy var cityView = ComingCityView()
    
    lazy var priceView = ComingPriceView()
    lazy var deleteButton: DefaultButton = {
        let btn = DefaultButton()
        btn.backgroundColor = #colorLiteral(red: 0.7874272466, green: 0.0006889323704, blue: 0, alpha: 1)
        btn.layer.cornerRadius = 0
        btn.setTitle(localized(text: "delete"), for: .normal)
        return btn
    }()
    lazy var watchButton: DefaultButton = {
        let btn = DefaultButton()
        btn.layer.cornerRadius = 0
        btn.setTitle(localized(text: "watch"), for: .normal)
        return btn
    }()
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {fatalError("")}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    // MARK: - Setup
    private func setupViews() -> Void {
        backgroundColor = .white
        
        contentView.isUserInteractionEnabled = false
        
        addSubviews([mainView])
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        mainView.addSubviews([dateTitle,cityView,
                              priceView,deleteButton,
                              watchButton])
        
        dateTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(19)
            make.centerX.equalToSuperview()
        }
        
        cityView.snp.makeConstraints { (make) in
            make.top.equalTo(dateTitle.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        priceView.snp.makeConstraints { (make) in
            make.top.equalTo(cityView.snp.bottom).offset(16)
            make.width.equalToSuperview()
            priceView.isHidden = true
            //make.bottom.equalToSuperview().offset(-16)
        }
        mainView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(cityView.snp.bottom).offset(25)
            make.width.equalTo(229)
            make.height.equalTo(36)
            make.centerX.equalToSuperview()
            
        }
        
        mainView.addSubview(freeLabel)
        freeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(-60)
            make.height.equalTo(30)
            make.width.equalTo(110)
        }
        
        mainView.addSubview(busyLabel)
        busyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.left.equalTo(freeLabel.snp.right).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(110)
        }
        
        mainView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalTo(freeLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(-60)
            make.height.equalTo(30)
            make.width.equalTo(110)
            make.bottom.equalToSuperview().offset(-16)
        }
        mainView.addSubview(watchButton)
        watchButton.snp.makeConstraints { (make) in
            make.top.equalTo(busyLabel.snp.bottom).offset(16)
            make.left.equalTo(deleteButton.snp.right).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(110)
            make.bottom.equalToSuperview().offset(-16)
        }
        
    }
    
    // MARK: - Configure
    func configure(model: ComingTripsModel) -> Void {
        typeCarTitle.text = model.car.name ?? ""
        cityView.fromCityTitle.text = model.from.city
        cityView.fromParkTitle.text = model.from.station
        cityView.toCityTitle.text = model.to.city
        cityView.toParkTitle.text = model.to.station
        var dateResult = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: model.departure_time.onlyDate()) {
            formatter.dateFormat = "dd.MM.yyyy"
            dateResult = formatter.string(from: date)
        }
        dateTitle.text = dateResult  + " / " + model.departure_time.onlyTime()
//        if model.car.image != nil { let url = model.car.image!.serverUrlString.url
//                                    carImage.kf.setImage(with: url)}
        priceLabel.text = "\(model.min_price ?? 0)-\(model.max_price ?? 0) ₸"
        
        freeLabel.text = "Свободно: \(model.count_free_places ?? 0)"
        var busyCount = 0
        var freeCount = model.count_free_places ?? 0
        switch model.car.car_type_id {
        case 1:
            busyCount = 53 - freeCount
        case 3:
            busyCount = 6 - freeCount
        case 5:
            busyCount = 4 - freeCount
        case 6:
            busyCount = 7 - freeCount
        case 7:
            busyCount = 62 - freeCount
        default:
            busyCount = 36 - freeCount
        }
        
        busyLabel.text = "Занято: \(busyCount)"
        
        
        
        
    }
}
