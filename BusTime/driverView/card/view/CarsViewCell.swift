//
//  CarsViewCell.swift
//  SaparLine
//
//  Created by Admin on 1/5/21.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit

class CarsViewCell: UITableViewCell {

    // MARK: - Properties
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor//UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 6
        return view
    }()
    lazy var typeCarTitle: UILabel = {
        let label = UILabel()
        label.text = "Тип транспорта №1"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 13)
        return label
    }()
    lazy var carsNumberTitle: UILabel = {
        let label = UILabel()
        label.text = "Номер машины"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    lazy var alertTitle: UILabel = {
        let label = UILabel()
        label.text = "В ожидании"
        label.textColor = .red
        label.font = UIFont.init(name: Font.mullerMedium, size: 16)
        return label
    }()
    lazy var carImage = UIImageView(image: #imageLiteral(resourceName: "Group 10491"))
 
    
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
        
        mainView.addSubviews([typeCarTitle,carsNumberTitle,carImage,alertTitle])
        typeCarTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)

        }
        carsNumberTitle.snp.makeConstraints { (make) in
            make.top.equalTo(typeCarTitle.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        alertTitle.snp.makeConstraints { (make) in
            make.top.equalTo(carsNumberTitle.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            
        }
        carImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(95)
            make.height.equalTo(70)
        }
       
    }
    
    // MARK: - Configure
    func configure(model: CarsListModel) -> Void {
        switch model.car_type_id ?? 0 {
        case 3:
            typeCarTitle.text = "Альфард"
        case 6:
            typeCarTitle.text = "Минивэн"
        case 5:
            typeCarTitle.text = "Такси"
        default:
            typeCarTitle.text = "Автобус"
        }
        
        carsNumberTitle.text = model.state_number ?? ""
       
        if model.avatar != nil { let url = model.avatar!.serverUrlString.url
                                    carImage.kf.setImage(with: url)}
        if model.is_confirmed == 0 {
            mainView.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.1769049658)
            alertTitle.isHidden = false
        }
        else {
            mainView.backgroundColor = .white
            alertTitle.isHidden = true
        }
        
    }
}
