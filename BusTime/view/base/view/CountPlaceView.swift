//
//  CountPlaceView.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class CountPlaceView: UIView {

    var count: Int = 1
    
    // MARK: - Properties
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = localized(text: "numberPlaces")
        label.numberOfLines = 2
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var minButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "Group 10483"), for: .normal)
        btn.addTarget(self, action: #selector(tapButton(button:)), for: .touchUpInside)
        btn.tag = 0
        return btn
    }()
    lazy var countTitle: UILabel = {
        let label = UILabel()
        label.text = "\(count)"
        label.textAlignment = .center
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerMedium, size: 18)
        return label
    }()
    lazy var maxButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "Group 10484"), for: .normal)
        btn.addTarget(self, action: #selector(tapButton(button:)), for: .touchUpInside)
        btn.tag = 1
        return btn
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews([title,maxButton,countTitle,minButton])
        title.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(minButton.snp.left)
        }
        maxButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        countTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(maxButton.snp.left)
            make.width.height.equalTo(40)
        }
        minButton.snp.makeConstraints { (make) in
            make.right.equalTo(countTitle.snp.left)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    // MARK: - Actions
    @objc func tapButton(button: UIButton) -> Void {
        button.tag == 0 ? (count == 1 ? (count = 1) : (count -= 1)) : (count += 1)
        countTitle.text = "\(count)"
    }
}
