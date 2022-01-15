//
//  ReviewTableViewCell.swift
//  SaparLine
//
//  Created by Bauyrzhan on 11.03.2021.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class ReviewTableViewCell: UITableViewCell {

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
    lazy private var ratingView: CosmosView = {
        let ratingView = CosmosView()
        ratingView.rating = 0
        ratingView.settings.starSize = 20
        ratingView.enableMode = .disabled
        return ratingView
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Бекарыс Ибрагим"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 13)
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Основание: Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        label.textColor = maincolor.blue
        label.numberOfLines = 0
        label.font = UIFont.init(name: Font.mullerMedium, size: 13)
        return label
    }()
    lazy var carImage = UIImageView(image: UIImage(named: "Group 10535"))
 
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {fatalError("")}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    // MARK: - Setup
    private func setupViews() -> Void {
        backgroundColor = .white
        contentView.isUserInteractionEnabled = true
        isUserInteractionEnabled = false
        
        addSubviews([mainView])
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
            
        }
        
        mainView.addSubviews([nameLabel,descriptionLabel,carImage, ratingView])
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(carImage.snp.right).offset(8)

        }
        ratingView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(carImage.snp.right).offset(8)
            
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ratingView.snp.bottom).offset(4)
            make.left.equalTo(carImage.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        carImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
       
    }
    
    // MARK: - Configure
    func configure(model: Feedback) -> Void {
        ratingView.rating = Double(model.rating ?? 0.0)
        if model.avatar != nil {
            let url = model.avatar?.serverUrlString.url
            carImage.kf.setImage(with: url)
        }
        descriptionLabel.text = "\(model.text ?? "")"
        nameLabel.text = "\(model.name ?? "") \(model.surname ?? "")"

        
    }
}
