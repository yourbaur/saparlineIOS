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

    var model: URL? {
        didSet {
            tourImage.kf.setImage(with: model)
        }
    }
    
    private lazy var tourImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "test")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
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
            make.height.equalTo(UIScreen.main.bounds.size.height / 4.5)
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
