//
//  HistoryOrdersTableViewCell.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/16/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
class HistoryOrdersTableViewCell: UITableViewCell {

    // MARK: - Properties
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 6
        view.backgroundColor = .white
        return view
    }()
    lazy var departureDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var departureTime: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var fromCity = CityDescriptionView()
    lazy var toCity: CityDescriptionView = {
        let view = CityDescriptionView()
        view.arrawImage.isHidden = true
        return view
    }()
    lazy var type: UILabel = {
        let label = UILabel()
        label.text = localized(text: "typeTrans") + ":"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var typeTitle: UILabel = {
        let label = UILabel()
        label.text = "Газель"
        label.textColor = .black
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var licensePlate: UILabel = {
        let label = UILabel()
        label.text = localized(text: "licensePlate") + ":"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var licensePlateTitle: UILabel = {
        let label = UILabel()
        label.text = "666xxx13"
        label.textColor = .black //UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var price: UILabel = {
        let label = UILabel()
        label.text = localized(text: "hisPrice")
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var priceTitle: UILabel = {
        let label = UILabel()
        label.text = "5 500тг"
        label.textColor = .black//UIColor(red: 0.184, green: 0.502, blue: 0.929, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    lazy var broneDate: UILabel = {
        let label = UILabel()
        label.text = localized(text: "bookingDate")
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var broneDateTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("")}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        mainView.addSubviews([fromCity,toCity,departureDate,departureTime,type,typeTitle,licensePlate,licensePlateTitle,price,priceTitle,broneDate,broneDateTitle])
        fromCity.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(18)
            make.centerX.equalToSuperview()
        }
        toCity.snp.makeConstraints { (make) in
            make.top.equalTo(fromCity.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        departureTime.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
        }
        departureDate.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        type.snp.makeConstraints { (make) in
            make.top.equalTo(toCity.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(16)
        }
        typeTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(type.snp.centerY)
            make.right.equalToSuperview().offset(-16)
        }
        licensePlate.snp.makeConstraints { (make) in
            make.top.equalTo(type.snp.bottom).offset(9)
            make.left.equalToSuperview().offset(16)
        }
        licensePlateTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(licensePlate.snp.centerY)
            make.right.equalToSuperview().offset(-16)
        }
        price.snp.makeConstraints { (make) in
            make.top.equalTo(licensePlate.snp.bottom).offset(9)
            make.left.equalToSuperview().offset(16)
        }
        priceTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(price.snp.centerY)
            make.right.equalToSuperview().offset(-16)
        }
        broneDate.snp.makeConstraints { (make) in
            make.top.equalTo(price.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(16)
        }
        broneDateTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(broneDate.snp.centerY)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Configure
    func configure(model: OrderHistoriesModel) -> Void {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        var date = formatter.date(from: model.departure_time)
        formatter.dateFormat = "dd.MM.yyyy"
        departureTime.text = model.departure_time.onlyTime()
        fromCity.cityTitle.text = model.from_city
        fromCity.parkTitle.text = model.from_station
        departureDate.text = formatter.string(from: date ?? Date())
        formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        
        date = formatter.date(from: model.created_at)
        formatter.dateFormat = "HH:mm dd.MM.yyyy"
        broneDateTitle.text = formatter.string(from: date ?? Date())
        
        toCity.timeTitle.text = model.destination_time.onlyTime()
        toCity.cityTitle.text = model.to_city
        toCity.parkTitle.text = model.to_station
        //toCity.dateTitle.text = formatter.string(from: date ?? Date())
        typeTitle.text = model.car_type
        licensePlateTitle.text = model.car_state_number
        priceTitle.text = "\(model.price) ₸"
    }
}
