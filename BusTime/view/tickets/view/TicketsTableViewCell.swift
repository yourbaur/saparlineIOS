//
//  TicketsTableViewCell.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/16/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class TicketsTableViewCell: UITableViewCell {

    lazy var carTypeCountPlaces = 0
    lazy var placeNumber = 0
    
    lazy var ticketImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"paid")
        imageView.tintColor = .white
        return imageView
    }()
    //lazy var timeView = TimeView()
    lazy var cityView = ComingCityView()
    lazy var timeNumber = NewDetailView(leftTitle: "Время", rightTitle: "А777ААА")
    lazy var carNumber = NewDetailView(leftTitle: "Номер авто", rightTitle: "А777ААА")
    lazy var numberPlace = NewDetailView(leftTitle: "Места", rightTitle: "08")
    lazy var name = NewDetailView(leftTitle: "ФИО", rightTitle: "Ойбой")
    lazy var iin = NewDetailView(leftTitle: "ИИН", rightTitle: "910101230412")
    lazy var sum = NewDetailView(leftTitle: "Сумма", rightTitle: "5000")
    lazy var sosPhone = NewDetailButton(leftTitle: "Экстренный вызов", rightTitle: "+7707 190 9009")

    lazy var returnButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle(localized(text: "return"), for: .normal)
        button.titleLabel?.font = UIFont.init(name: Font.mullerMedium, size: 14)
        
        return button
    }()
    
    lazy var waitingLabel: UILabel = {
        let label = UILabel()
        label.text = "В ожидании"
        label.textColor = .red
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        contentView.isUserInteractionEnabled = false
        cityView.backgroundColor = .clear
        addSubview(ticketImage)
        ticketImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
        ticketImage.addSubviews([returnButton,cityView,carNumber, timeNumber,numberPlace, name, iin, sum, sosPhone])
//        timeView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(12)
//            make.left.equalToSuperview().offset(22)
//            make.right.equalToSuperview().offset(-22)
//        }
        cityView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(26)
            make.left.equalToSuperview().offset(28)
            make.right.equalToSuperview().offset(-22)
        }
        carNumber.snp.makeConstraints { (make) in
            make.top.equalTo(cityView.snp.bottom).offset(8)
            switch UIDevice.modelName {
            case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus":
                make.left.equalToSuperview().offset(32)
            default: make.left.equalToSuperview().offset(28)
                
            }
            
            make.right.equalToSuperview().offset(-22)
        }
        timeNumber.snp.makeConstraints { (make) in
            make.top.equalTo(carNumber.snp.bottom).offset(6)
            switch UIDevice.modelName {
            case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus":
                make.left.equalToSuperview().offset(32)
            default: make.left.equalToSuperview().offset(28)
                
            }
            make.right.equalToSuperview().offset(-22)
        }
        numberPlace.snp.makeConstraints { (make) in
            make.top.equalTo(timeNumber.snp.bottom).offset(6)
            switch UIDevice.modelName {
            case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus":
                make.left.equalToSuperview().offset(32)
            default: make.left.equalToSuperview().offset(28)
                
            }
            make.right.equalToSuperview().offset(-22)
        }
        
        name.snp.makeConstraints { (make) in
            make.top.equalTo(numberPlace.snp.bottom).offset(6)
            switch UIDevice.modelName {
            case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus":
                make.left.equalToSuperview().offset(32)
            default: make.left.equalToSuperview().offset(28)
                
            }
            make.right.equalToSuperview().offset(-22)
        }
        
        iin.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).offset(6)
            switch UIDevice.modelName {
            case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus":
                make.left.equalToSuperview().offset(32)
            default: make.left.equalToSuperview().offset(28)
                
            }
            make.right.equalToSuperview().offset(-22)
        }
        
        sum.snp.makeConstraints { (make) in
            make.top.equalTo(iin.snp.bottom).offset(6)
            switch UIDevice.modelName {
            case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus":
                make.left.equalToSuperview().offset(32)
            default: make.left.equalToSuperview().offset(28)
                
            }
            make.right.equalToSuperview().offset(-22)
        }
        
        sosPhone.snp.makeConstraints { (make) in
            make.top.equalTo(sum.snp.bottom).offset(6)
            switch UIDevice.modelName {
            case "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 11", "iPhone 11 Pro Max", "iPhone XR", "iPhone XS Max", "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus":
                make.left.equalToSuperview().offset(32)
            default: make.left.equalToSuperview().offset(28)
                
            }
            make.right.equalToSuperview().offset(-22)
        }
        
        returnButton.snp.makeConstraints { (make) in
            make.top.equalTo(sosPhone.snp.bottom).offset(6)
            make.width.equalTo(120)
            make.height.equalTo(36)
            make.centerX.equalToSuperview().offset(20)
        }
     
    }
    
    // MARK: - Configure
    func configure(model: MyTicketsModel) -> Void {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        let date = formatter.date(from: model.departure_time!)
        var dateResult = ""
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: model.departure_time!.onlyDate()) {
            formatter.dateFormat = "dd.MM.yyyy"
            dateResult = formatter.string(from: date)
        }
        timeNumber.rightTitle.text = dateResult + " / " +  model.departure_time!.onlyTime()
        if let date = date {
            let now = Date()
            if date < now {
                ticketImage.image = #imageLiteral(resourceName: "Vector-2").withRenderingMode(.alwaysTemplate)
                ticketImage.tintColor = UIColor(red: 226/255, green: 160/255, blue: 160/255, alpha: 1)
                
            } else {
                ticketImage.image = #imageLiteral(resourceName: "Vector-2")
                ticketImage.tintColor = .white
               
            }
        }
//        formatter.dateFormat = "dd.MM.yyyy"
//        timeView.fromTime.text = model.departure_time.onlyTime()
//        timeView.fromDate.text = formatter.string(from: date ?? Date())
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
//        date = formatter.date(from: model.destination_time)
//        formatter.dateFormat = "dd.MM.yyyy"
//        timeView.toTime.text = model.destination_time.onlyTime()
//        timeView.toDate.text = formatter.string(from: date ?? Date())
        
        cityView.fromCityTitle.text = model.from_city
        cityView.fromParkTitle.text = model.from_station
        cityView.toCityTitle.text = model.to_city
        cityView.toParkTitle.text = model.to_station
        carNumber.rightTitle.text = model.car_state_number
        
        name.rightTitle.text = model.first_name ?? "Oiboi"
        iin.rightTitle.text = model.iin ?? "910101120111"
        sum.rightTitle.text = "\(model.price ?? 10000) тг"
        
        //timeNumber.rightTitle.text = model.car_state_number
        carTypeCountPlaces = model.car_type_count_places!
        var places = ""

        placeNumber = model.number ?? 0
            if carTypeCountPlaces == 36  {
                switch placeNumber {
                case 1...16:
                    places += "\(placeNumber)↓"
                case 17...32:
                    places += "\(placeNumber - 16)↑"
                case 33,34:
                    places += "0↑"
                case 35,36:
                    places += "0↓"
                default:
                    places += "\(placeNumber)"
                }
            } else {
                places +=  "\(placeNumber)"
            }
        numberPlace.rightTitle.text = places
        returnButton.tag = model.id!
        
        if model.status == "in_process" {
            ticketImage.image = UIImage(named: "unpaid")
            returnButton.isHidden = true
            
        }
        else {
            ticketImage.image = UIImage(named: "paid")
        }
        
    }
    
    @objc func makeCall(sender: PhoneButton) {
        sender.phone.makeCall()
    }
}
