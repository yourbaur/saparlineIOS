//
//  SearchResultTableViewCell.swift
//  BusTime
//
//  Created by greetgo on 8/17/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import Cosmos

class SearchResultTableViewCell: UITableViewCell {

    // MARK: - Properties
    lazy var mainView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bus-1")
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        return view
    }()
    
    lazy var placeView:UIImageView = {
       let view = UIImageView()
       view.image = UIImage(named:"bluePlace")
       return view
    }()
    lazy var freePlaceView:UIImageView = {
       let view = UIImageView()
       view.image = UIImage(named:"freePlace")
       return view
    }()
    lazy var nameTitle: UILabel = {
        let label = UILabel()
        label.text = "Автобус"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    lazy var typeTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerMedium, size: 14)
        return label
    }()
    
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.cornerRadius = 2
        label.text = "55"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.init(name: Font.mullerMedium, size: 10)
        label.backgroundColor = #colorLiteral(red: 0.2607415318, green: 0.3797456622, blue: 0.6464452744, alpha: 1)
        return label
    }()

    lazy var freeTitle: UILabel = {
        let label = UILabel()
        label.text = "? мест свободно"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 10)
        return label
    }()
    lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.text = "14:30 / 24 июля 2020г"
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.init(name: Font.mullerMedium, size: 14)
        return label
    }()
    lazy var ratingTitle: UILabel = {
        let label = UILabel()
        label.text = "5.5"
        label.textColor = .black
        label.font = UIFont.init(name: Font.mullerMedium, size: 14)
        return label
    }()
    
    lazy var parkImage = UIImageView(image: UIImage(named:"midLine"))
    lazy var parkTitle: UILabel = {
        let label = UILabel()
        label.text = "Сайран автовокзал"
        label.numberOfLines = 2
        label.textColor = .black
        
        label.font = UIFont.init(name: Font.mullerMedium, size: 14)
        return label
    }()
    lazy var stackPlaces: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }()
    lazy var stateTitle: UILabel = {
        let label = UILabel()
        label.text = "Сайран"
        label.numberOfLines = 2
        label.textColor = .lightGray
        
        label.font = UIFont.init(name: Font.mullerRegular, size: 10)
        return label
    }()
    lazy var toStateTitle: UILabel = {
        let label = UILabel()
        label.text = "Сайран"
        label.numberOfLines = 2
        label.textColor = .lightGray
        
        label.font = UIFont.init(name: Font.mullerRegular, size: 10)
        return label
    }()
    lazy var toParkTitle: UILabel = {
        let label = UILabel()
        label.text = "Сайран"
        label.numberOfLines = 2
        label.textColor = .black
        
        label.font = UIFont.init(name: Font.mullerMedium, size: 14)
        return label
    }()
    
    lazy private var ratingView: CosmosView = {
        let ratingView = CosmosView()
        ratingView.rating = 4.5
        ratingView.settings.filledColor = .yellow
        ratingView.settings.starSize = 15

        return ratingView
    }()


    lazy var reservButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle(localized(text: "brone"), for: .normal)
        button.isHidden = true
        button.isEnabled = false
        return button
    }()
    lazy var sliderBtn: MyButton = {
        let btn = MyButton()
        btn.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        btn.backgroundColor = .clear
        return btn
    }()
    lazy var timeImage = UIImageView(image: UIImage(named: "timeIcon"))
    lazy var priceImage = UIImageView(image: UIImage(named: "priceIcon"))
    lazy var carImage = UIImageView(image: #imageLiteral(resourceName: "Group 10491"))
    lazy var lineImage = UIImageView(image: UIImage(named: "lineIcon"))
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.text = localized(text: "priceSeat")
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 12)
        return label
    }()
    lazy var priceTitle1: UILabel = {
        let label = UILabel()
        label.text = "4 000-5 000 T"
        label.textColor = #colorLiteral(red: 0.05386027694, green: 0.6967057586, blue: 0.5264524221, alpha: 1)
        label.font = UIFont.init(name: Font.mullerBold, size: 18)
        return label
    }()
    lazy var priceTitle2: UILabel = {
        let label = UILabel()
        label.text = "400"
        label.textColor = #colorLiteral(red: 0.05386027694, green: 0.6967057586, blue: 0.5264524221, alpha: 1)
        label.font = UIFont.init(name: Font.mullerBold, size: 18)
        return label
    }()
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("")}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        contentView.isUserInteractionEnabled = false
        isUserInteractionEnabled = true
        mainView.isUserInteractionEnabled = true
      
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        mainView.addSubviews([freeTitle, countLabel, ratingView, dateTitle,parkImage,parkTitle,toParkTitle,stateTitle, toStateTitle,
            carImage,priceTitle1, priceTitle2, timeImage, lineImage, priceImage, stackPlaces, ratingTitle,sliderBtn])
     
     
        freeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(toParkTitle.snp.bottom).offset(16)
            make.left.equalTo(carImage.snp.right).offset(5)
        }
        stackPlaces.snp.makeConstraints { (make) in
            make.top.equalTo(toParkTitle.snp.bottom).offset(16)
            make.left.equalTo(freeTitle.snp.right).offset(5)
        }
        countLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(freeTitle)
            make.left.equalTo(freeTitle.snp.right).offset(2)
            make.width.height.equalTo(17)
            countLabel.isHidden = true
            
        }
        ratingView.snp.makeConstraints { (make) in
            make.top.equalTo(freeTitle.snp.bottom).offset(13)
            make.left.equalTo(carImage.snp.right).offset(5)
            
        }
        ratingTitle.snp.makeConstraints { (make) in
            make.top.equalTo(freeTitle.snp.bottom).offset(13)
            make.left.equalTo(ratingView.snp.right).offset(5)
            
        }
        dateTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeImage)
            make.left.equalTo(timeImage.snp.right).offset(2)
        }
        timeImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-66)
            make.width.height.equalTo(11)
        }
        parkImage.snp.makeConstraints { (make) in
            //make.top.equalTo(dateTitle.snp.bottom).offset(12)
            make.top.equalToSuperview().offset(30)
            make.left.equalTo(carImage.snp.right).offset(8)
            make.width.equalTo(8)
            make.height.equalTo(37)
        }
        
        parkTitle.snp.makeConstraints { (make) in
            make.left.equalTo(parkImage.snp.right).offset(5)
            make.centerY.equalTo(parkImage.snp.top).offset(2)
            
        }
        toParkTitle.snp.makeConstraints { (make) in
            make.left.equalTo(parkImage.snp.right).offset(5)
            make.centerY.equalTo(parkImage.snp.bottom).offset(-2)
            
        }
        
        stateTitle.snp.makeConstraints { (make) in
            make.left.equalTo(parkTitle.snp.right).offset(5)
            make.centerY.equalTo(parkTitle)
            make.width.equalTo(45)
            
        }
        toStateTitle.snp.makeConstraints { (make) in
            make.left.equalTo(toParkTitle.snp.right).offset(5)
            make.centerY.equalTo(toParkTitle)
            make.width.equalTo(45)
            
        }
        
        
        sliderBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(95)
            make.height.equalTo(120)
        }
        carImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(95)
            make.height.equalTo(120)
        }
       
        priceTitle1.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalTo(lineImage.snp.top).offset(-5)
        }
        priceImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineImage)
            make.right.equalTo(lineImage.snp.left).offset(-6)
            make.width.height.equalTo(11)
        }

        lineImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalTo(priceTitle2.snp.top).offset(-5)
            make.width.equalTo(36)
            make.height.equalTo(1)
        }
        priceTitle2.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    // MARK: - Configure
    func configure(model: TravelList) -> Void {
        let formatter = DateFormatter()
        let date2 = formatter.date(from: model.destination_time) ?? Date()
        formatter.dateFormat = "HH:mm"
        let dateStr2 = formatter.string(from: date2)
        let arriveTime = model.departure_time.onlyTime()
     
        freeTitle.text = "Места"
        countLabel.isHidden = true
        stackPlaces.isHidden = false
        for stack in stackPlaces.arrangedSubviews {
            stackPlaces.removeArrangedSubview(stack)
        }
        
        if model.car.car_type_id == 3 {
            for _ in 0..<(6-model.count_free_places!){
                let place = UIImageView()
                place.image = UIImage(named: "freePlace")
                stackPlaces.addArrangedSubview(place)
            }
            for _ in 0..<(model.count_free_places!){
                let place = UIImageView()
                place.image = UIImage(named: "bluePlace")
                stackPlaces.addArrangedSubview(place)
            }
        }
        
        else if model.car.car_type_id == 5 {
            for _ in 0..<(4-model.count_free_places!){
                let place = UIImageView()
                place.image = UIImage(named: "freePlace")
                stackPlaces.addArrangedSubview(place)
            }
            for _ in 0..<(model.count_free_places!){
                let place = UIImageView()
                place.image = UIImage(named: "bluePlace")
                stackPlaces.addArrangedSubview(place)
            }
        }
        
        else if model.car.car_type_id == 6 {
            for _ in 0..<(7-model.count_free_places!){
                let place = UIImageView()
                place.image = UIImage(named: "freePlace")
                stackPlaces.addArrangedSubview(place)
            }
            for _ in 0..<(model.count_free_places!){
                let place = UIImageView()
                place.image = UIImage(named: "bluePlace")
                stackPlaces.addArrangedSubview(place)
            }
        }
        else if model.car.car_type_id == 8 {
            for _ in 0..<(28-model.count_free_places!){
                let place = UIImageView()
                place.image = UIImage(named: "freePlace")
                stackPlaces.addArrangedSubview(place)
            }
            for _ in 0..<(model.count_free_places!){
                let place = UIImageView()
                place.image = UIImage(named: "bluePlace")
                stackPlaces.addArrangedSubview(place)
            }
        }
        
        else if model.car.car_type_id == 9 {
            for _ in 0..<(29-model.count_free_places!){
                let place = UIImageView()
                place.image = UIImage(named: "freePlace")
                stackPlaces.addArrangedSubview(place)
            }
            for _ in 0..<(model.count_free_places!){
                let place = UIImageView()
                place.image = UIImage(named: "bluePlace")
                stackPlaces.addArrangedSubview(place)
            }
        }
        else {
            stackPlaces.isHidden = true
            freeTitle.text = "Свободные места"
            countLabel.isHidden = false
            countLabel.text = String(describing: model.count_free_places!)
            
        }
        
        
        
        nameTitle.text = model.car.name
        typeTitle.text = model.car.car_type_id == 2 ? "Спальный салон" : ""
        
        
        dateTitle.text = arriveTime
        parkTitle.text = "\(model.from?.city ?? "")"
        toParkTitle.text = "\(model.to?.city  ?? "")"
        stateTitle.text = "\(model.from?.station ?? "")"
        toStateTitle.text = "\(model.to?.station ?? "")"
        parkTitle.text = "\(model.from?.city ?? "")"
        priceTitle1.text = "\(model.min_price ?? 0)"
        priceTitle2.text = "\(model.max_price ?? 0)"
        ratingView.rating = Double(model.car.rating ?? 0.0) ?? 0.0
        ratingTitle.text = "\(Double(model.car.rating ?? 0.0) ?? 0.0)".substring(with: 0..<3)
        let url = (model.car.avatar ?? "").serverUrlString.url
        carImage.kf.setImage(with: url)
         //   - \(model.from?.station ?? "")
        //- \(model.to?.station ?? "")
        //
        //
    }
    
    //MARK: - Actions
    @objc
    func tapButton() {
        print("WORK")
    }
}
