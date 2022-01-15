
//  LTGas
//  Created by Tuigynbekov Yelzhan on 1/29/20.
//  Copyright © 2020 Tuigynbekov Yelzhan. All rights reserved.

import UIKit

class DefaultTextField: UITextField {
    
    // MARK: - Properties
    lazy var imageProfile: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "asd")
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var rightImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Vector-1")
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var actionButton = UIButton()

    // MARK: - Lifecycle
    required init?(coder: NSCoder) {fatalError("")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupViews()
    }
    
    // MARK: - Setup
    func setupViews() -> Void {
        text = ""
        textColor = maincolor.blue
        tintColor = maincolor.blue
        
        font = UIFont.init(name: Font.mullerRegular, size: 14)
        keyboardType = .numberPad
        layer.cornerRadius = 5
        
        let space = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 0))
        leftView = space
        leftViewMode = .always
        
        addSubview(imageProfile)
        imageProfile.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.width.height.equalTo(20)
        }
        addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        addSubview(actionButton)
        actionButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
    }
}
