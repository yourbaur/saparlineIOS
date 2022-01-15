//
//  SitCollectionViewCell.swift
//  Bus_time_MAIN
//
//  Created by Bakdaulet Myrzakerov on 8/3/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class SitDriverCollectionViewCell: UICollectionViewCell {
    
    lazy var status = 0
    lazy var placeNumBack = 0
    lazy var sitImageView : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Group-16")
        image.clipsToBounds = true
        return image
    }()
    lazy var placeNumber: UILabel = {
        let label = UILabel()
        label.text = "01"
        label.textColor = .black
        label.font = UIFont.init(name: Font.mullerRegular, size: 12)
        return label
    }()

    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews([sitImageView,placeNumber])
        sitImageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        placeNumber.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isHidden = false
    }
}
