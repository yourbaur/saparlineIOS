//
//  NewsCollectionViewCell.swift
//  SaparLine
//
//  Created by Admin on 1/16/21.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    var news: SliderPhoto! {
        didSet {
            //imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.kf.setImage(with: news.image.serverUrlString.url)
        }
    }
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNews(news: SliderPhoto){
        self.news = news
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-20)
            make.left.equalTo(20)
            make.bottom.equalTo(-10)
        }
    }
    
}
