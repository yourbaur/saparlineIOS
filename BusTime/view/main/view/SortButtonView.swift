//
//  SortButtonView.swift
//  SaparLine
//
//  Created by Bauyrzhan on 28.02.2021.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit

class SortButtonView: UIView {
    
    // MARK: - Properties
    lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сортировать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        button.backgroundColor = maincolor.blue
        button.layer.cornerRadius = 8
        button.contentMode = .center
        
        button.setImage(UIImage(named: "sort"), for: .normal)
        let spacing = 10; // the amount of spacing to appear between image and title
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 3, right: CGFloat(spacing));
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat(spacing), bottom: 3, right: 0);
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        
        return button
    }()
    
    // MARK: - Init
    required init?(coder: NSCoder) { fatalError("") }
    init() {
        super.init(frame: .zero)
        
        setupViws()
    }
    
    // MARK: - SetupViews
    private func setupViws() {
        addSubview(sortButton)
        sortButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(90)
            make.right.equalToSuperview().offset(-90)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
