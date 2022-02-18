//
//  TourSwitcherView.swift
//  SaparLine
//
//  Created by Cheburek on 17.02.2022.
//  Copyright © 2022 thousand.com. All rights reserved.
//

import UIKit

final class TourSwitcherView: UIView {
    
    //MARK: - Properties
    var firstAction: (() -> ())?
    var secondAction: (() -> ())?
    var thirdAction: (() -> ())?
    
    var isselected = false
    var selectedButton: UIButton? {
        didSet{
            self.setupGradientView()
            self.isselected = true
            let buttons = [firstButton, secondButton, thirdButton]
            for button in buttons {
                button.setTitleColor(#colorLiteral(red: 0.1607843137, green: 0.2431372549, blue: 0.4235294118, alpha: 1), for: .normal)
            }
            self.selectedButton!.setTitleColor(#colorLiteral(red: 0.1607843137, green: 0.2431372549, blue: 0.4235294118, alpha: 1), for: .normal)
        }
    }
    lazy var firstButton: UIButton = {
        let button = UIButton()
        button.addRightIcon(image: UIImage(named:"bus")!)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
        
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.addRightIcon(image: UIImage(named:"alphard")!)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
        return button
    }()
    lazy var thirdButton: UIButton = {
        let button = UIButton()
        button.addRightIcon(image: UIImage(named:"taxi")!)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
        return button
        
    }()
    
    var bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    var currentCount: Int!
    
    //MARK: - Initialization
    init(firstTitle: String, secondTitle: String,thirdTitle: String) {
        super.init(frame: .zero)
        firstButton.setTitle(firstTitle, for: .normal)
        secondButton.setTitle(secondTitle, for: .normal)
        thirdButton.setTitle(thirdTitle, for: .normal)
        setupView()
        setupAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup function
    private func setupView() -> Void {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        addSubview(bottomView)
        addSubview(firstButton)
        addSubview(secondButton)
        addSubview(thirdButton)
        
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.33)
        }
        
        firstButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
        }
        
        thirdButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
            make.right.equalToSuperview()
        }
        
        secondButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.right.equalTo(thirdButton.snp.left)
            make.left.equalTo(firstButton.snp.right)
        }
    }
    
    private func setupAction() -> Void {
        firstButton.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
    }
    
    private func setupGradientView() {
        self.bottomView.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.2431372549, blue: 0.4235294118, alpha: 1)
    }
    
    //    MARK: - Simple functions
    func firstButtonSelected() -> Void {
        selectedButton = firstButton
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.width.centerX.equalTo(self.firstButton)
                make.height.equalTo(2)
            }
            self.superview?.layoutIfNeeded()
        }
        firstAction?()
    }
    
    func secondButtonSelected() -> Void {
        selectedButton = secondButton
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.width.centerX.equalTo(self.secondButton)
                make.height.equalTo(2)
            }
            self.superview?.layoutIfNeeded()
        }
        secondAction?()
    }
    
    func thirdButtonSelected() -> Void {
        selectedButton = thirdButton
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.width.centerX.equalTo(self.thirdButton)
                make.height.equalTo(2)
            }
            self.superview?.layoutIfNeeded()
        }
        thirdAction?()

    }
    
    //MARK: - Objective function
    @objc func buttonPressed(sender: UIButton) -> Void {
        if selectedButton != sender {
            if sender == firstButton {
                firstButtonSelected()
            } else if sender == secondButton {
                secondButtonSelected()
            }
            else if sender == thirdButton{
               thirdButtonSelected()
            }
        }
    }
    
}

