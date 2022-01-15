//
//  MapView.swift
//  BusTime
//
//  Created by greetgo on 9/19/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import GoogleMaps
class MapView: UIView {

    lazy var textTitle: UILabel = {
        let label = UILabel()
        label.text = "Местоположение автостоянки:"
        label.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 12)
        return label
    }()
    lazy var googleMap: GMSMapView = {
        let map = GMSMapView()
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        map.settings.compassButton = true
        map.layer.cornerRadius = 5
        return map
    }()
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews([textTitle,googleMap])
        textTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        googleMap.snp.makeConstraints { (make) in
            make.top.equalTo(textTitle.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(140)
            make.bottom.equalToSuperview()
        }
    }
}
