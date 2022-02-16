//
//  TourImagesCell.swift
//  SaparLine
//
//  Created by Cheburek on 12.02.2022.
//  Copyright © 2022 thousand.com. All rights reserved.
//

import UIKit
import SnapKit

class TourImagesCell: UICollectionViewCell {

    static let identifier = "TourImagesCell"

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        [label, subLabel].forEach { $0.text = nil }
//    }
    
    lazy var tourImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "test")
        view.layer.cornerRadius = 10
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        setupViews()
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(tourImage)
    }

    private func setupConstraints() {
        tourImage.snp.makeConstraints { make in
            make.top.equalTo(4)
            make.height.equalTo(UIScreen.main.bounds.size.height / 4.5)
//            make.leading.trailing.equalToSuperview()
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.bottom.equalTo(-4)
        }
    }
}
