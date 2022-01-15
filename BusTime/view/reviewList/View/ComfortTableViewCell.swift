//
//  ComfortTableViewCell.swift
//  SaparLine
//
//  Created by Bauyrzhan on 12.03.2021.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit

class ComfortTableViewCell: UITableViewCell {

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
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Телевизор"
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 13)
        return label
    }()
    lazy var carImage = UIImageView(image: #imageLiteral(resourceName: "television"))
 
    
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
        
        mainView.addSubviews([nameLabel, carImage])
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(carImage.snp.right).offset(16)

        }
        carImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
       
    }
    
    // MARK: - Configure
    func configure(model: Comfort) -> Void {
        carImage.image = UIImage(named: model.image ?? "")
        nameLabel.text = model.title ?? ""
    }
}
