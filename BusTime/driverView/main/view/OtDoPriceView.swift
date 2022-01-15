//
//  OtDoPriceView.swift
//  BusTime
//
//  Created by greetgo on 10/23/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class OtDoPriceView: UIView {

    let space = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 0))
    var ot = 0
    var first = false
    var doo = 0
    var price = 500
    weak var delegate:DeleteDelegate?
    
    // MARK: - Properties
    lazy var otDoLabel: UILabel = {
        let label = UILabel()
        label.text = "От \(ot) до \(doo) мест"
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "Group 10483"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(tapMinus), for: .touchUpInside)
        return button
    }()
    lazy var priceField: UITextField = {
        let field = UITextField()
        field.text = "\(price) ₸"
        field.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        field.font = UIFont.init(name: Font.mullerBold, size: 18)
        field.isUserInteractionEnabled = false
        field.textAlignment = .center
        return field
    }()
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "Group 10484"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(tapPlus), for: .touchUpInside)
        return button
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "trash"), for: .normal)
        button.setBackgroundImage(button.backgroundImage(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = maincolor.blue
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(tapEdit), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    required init?(coder: NSCoder) { fatalError("")}
    init(ot: String, doo: String, price:Int) {
        super.init(frame: .zero)
        self.price = price
        self.ot = Int(ot) ?? 0
        self.doo = Int(doo) ?? 0
        backgroundColor = .white
        invalidateIntrinsicContentSize()
        
        addSubviews([otDoLabel, deleteButton, minusButton, priceField, plusButton])
        otDoLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(16)
        }
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(18)
            make.left.equalTo(otDoLabel.snp.right).offset(5)
            make.width.height.equalTo(20)
        }
        minusButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.equalTo(priceField.snp.left)
            make.width.height.equalTo(40)
        }
        priceField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(18)
            make.width.equalTo(75)
            make.right.equalTo(plusButton.snp.left)
        }
        plusButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(40)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        var size = CGSize()
        size.height = 60
        return size
    }
    
    @objc func tapMinus() {
        if price >= 1000 {
            price -= 500
        }
        priceField.text = "\(price) ₸"
    }
    
    @objc func tapPlus() {
        price += 500
        priceField.text = "\(price) ₸"
    }
    
    @objc func tapEdit() {
        otDoLabel.removeFromSuperview()
        priceField.removeFromSuperview()
        minusButton.removeFromSuperview()
        plusButton.removeFromSuperview()
        deleteButton.removeFromSuperview()
        if otDoLabel.text == "1 место"{
            delegate?.delete()}
        removeFromSuperview()
    }
}



protocol DeleteDelegate:class {
    func delete()
}
