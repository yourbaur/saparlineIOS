
//  LTGas
//  Created by Tuigynbekov Yelzhan on 1/29/20.
//  Copyright © 2020 Tuigynbekov Yelzhan. All rights reserved.

import UIKit
class DefaultButton: UIButton {
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        backgroundColor = maincolor.blue
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.init(name: Font.mullerMedium, size: 16)
    }
}
class DefaultReserveButton: UIButton {
    
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        backgroundColor = .white
        setTitleColor(.lightGray, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = maincolor.blue.cgColor
        titleLabel?.font = UIFont.init(name: Font.mullerMedium, size: 16)
    }
}
