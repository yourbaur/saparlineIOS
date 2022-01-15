//
//  SortViewCell.swift
//  SaparLine
//
//  Created by Bauyrzhan on 28.02.2021.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit

class SortTableViewCell: UITableViewCell {

    lazy var itemSelected = false
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
    }
}
