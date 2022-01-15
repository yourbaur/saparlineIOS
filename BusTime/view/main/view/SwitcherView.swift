//
//  SwitcherView.swift
//  SaparLine
//
//  Created by Admin on 1/3/21.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit

class SwitcherView: UIView {
    
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
//        button.setImage(, for: .normal)
//        button.frame = CGRect(x: 0, y: 0, width: 4, height: 4)
//        button.imageView?.contentMode = .scaleAspectFit
//        let imageSize:CGSize = CGSize(width: 5, height: 5)
//
//        button.semanticContentAttribute = .forceLeftToRight
//        button.imageEdgeInsets =  UIEdgeInsets(
//            top: 10.0,
//            left: 30.0,
//            bottom:10.0,
//            right: 30.0)
//
//
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
        
        return button
    }()
    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.addRightIcon(image: UIImage(named:"alphard")!)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
//        button.frame = CGRect(x: 200, y: 200, width: 5, height: 5)
//        button.imageView?.contentMode = .scaleAspectFit
//        let imageSize:CGSize = CGSize(width: 5, height: 5)
//
//        button.imageEdgeInsets =  UIEdgeInsets(
//            top: 10.0,
//            left: 10.0,
//            bottom: 10.0,
//            right: 10.0)
//
//            button.setTitleColor(.white, for: .normal)
//            button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
//
        return button
    }()
    lazy var thirdButton: UIButton = {
        let button = UIButton()
        button.addRightIcon(image: UIImage(named:"taxi")!)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
        //        button.frame = CGRect(x: 200, y: 200, width: 5, height: 5)
//        button.imageView?.contentMode = .scaleAspectFit
//        let imageSize:CGSize = CGSize(width: 5, height: 5)
//        button.imageEdgeInsets =  UIEdgeInsets(
//            top: 10.0,
//            left: 0.0,
//            bottom: 10.0,
//            right: 0.0)
//
//            button.setTitleColor(.white, for: .normal)
//            button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
//
        return button
        
    }()
    
    var bottomView: UIView = {
        let view = UIView()
    
        return view
    }()
    var currentCount: Int!
    //MARK: - Initialization
    init(firstTitle: String, secondTitle: String) {
        super.init(frame: .zero)
        
        
        firstButton.setTitle(firstTitle, for: .normal)
        secondButton.setTitle(secondTitle, for: .normal)
        
        currentCount = 3
        setupView(currentCount)
        setupAction()
    }
    init(firstTitle: String, secondTitle: String,thirdTitle: String) {
        super.init(frame: .zero)
    
        
        firstButton.setTitle(firstTitle, for: .normal)
        secondButton.setTitle(secondTitle, for: .normal)
        thirdButton.setTitle(thirdTitle, for: .normal)
        currentCount = 3
        setupView(currentCount)
        setupAction()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup function
    private func setupView(_ count:Int) -> Void {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        if count == 2 {
            addSubview(bottomView)
            bottomView.snp.makeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.right.equalTo(snp.centerX)
                make.bottom.equalToSuperview()
            }

            addSubview(firstButton)
            firstButton.snp.makeConstraints { (make) in
                make.height.equalTo(40)
                make.left.top.bottom.equalToSuperview()
                make.right.equalTo(snp.centerX)
            }
            addSubview(secondButton)
            secondButton.snp.makeConstraints { (make) in
                make.height.equalTo(40)
                make.right.top.bottom.equalToSuperview()
                make.left.equalTo(snp.centerX)
            }
            }
        else {
            addSubview(bottomView)
            addSubview(firstButton)
            addSubview(secondButton)
            addSubview(thirdButton)
            
            bottomView.snp.makeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.33)
//                make.height.equalTo(40)
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
        if currentCount == 2 {
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.right.equalTo(self.snp.centerX)
                make.height.equalTo(2)
     
            }
            self.superview?.layoutIfNeeded()
        }
        }
        else {
            UIView.animate(withDuration: 0.3) {
                self.bottomView.snp.remakeConstraints { (make) in
                    make.bottom.equalToSuperview()
                    make.width.centerX.equalTo(self.firstButton)
                    make.height.equalTo(2)
                  }
                self.superview?.layoutIfNeeded()
            }
        }
        firstAction?()
    }
    
    func secondButtonSelected() -> Void {
        selectedButton = secondButton
        if currentCount == 2{
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.height.equalTo(2)
                make.right.bottom.equalToSuperview()
                make.left.equalTo(self.snp.centerX)
            }
            self.superview?.layoutIfNeeded()
        }
        }
        else{
            UIView.animate(withDuration: 0.3) {
                self.bottomView.snp.remakeConstraints { (make) in
                    make.bottom.equalToSuperview()
                    make.width.centerX.equalTo(self.secondButton)
                    make.height.equalTo(2)
                }
                self.superview?.layoutIfNeeded()
          }
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

class SwitcherReviewView: UIView {
    
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
//        button.setImage(, for: .normal)
//        button.frame = CGRect(x: 0, y: 0, width: 4, height: 4)
//        button.imageView?.contentMode = .scaleAspectFit
//        let imageSize:CGSize = CGSize(width: 5, height: 5)
//
//        button.semanticContentAttribute = .forceLeftToRight
//        button.imageEdgeInsets =  UIEdgeInsets(
//            top: 10.0,
//            left: 30.0,
//            bottom:10.0,
//            right: 30.0)
//
//
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
        
        return button
    }()
    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
//        button.frame = CGRect(x: 200, y: 200, width: 5, height: 5)
//        button.imageView?.contentMode = .scaleAspectFit
//        let imageSize:CGSize = CGSize(width: 5, height: 5)
//
//        button.imageEdgeInsets =  UIEdgeInsets(
//            top: 10.0,
//            left: 10.0,
//            bottom: 10.0,
//            right: 10.0)
//
//            button.setTitleColor(.white, for: .normal)
//            button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
//
        return button
    }()
    lazy var thirdButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
        //        button.frame = CGRect(x: 200, y: 200, width: 5, height: 5)
//        button.imageView?.contentMode = .scaleAspectFit
//        let imageSize:CGSize = CGSize(width: 5, height: 5)
//        button.imageEdgeInsets =  UIEdgeInsets(
//            top: 10.0,
//            left: 0.0,
//            bottom: 10.0,
//            right: 0.0)
//
//            button.setTitleColor(.white, for: .normal)
//            button.titleLabel?.font = UIFont.init(name: Font.mullerRegular, size: 10)
//
        return button
        
    }()
    
    var bottomView: UIView = {
        let view = UIView()
    
        return view
    }()
    var currentCount: Int!
    //MARK: - Initialization
    init(firstTitle: String, secondTitle: String) {
        super.init(frame: .zero)
        
        
        firstButton.setTitle(firstTitle, for: .normal)
        secondButton.setTitle(secondTitle, for: .normal)
        
        currentCount = 3
        setupView(currentCount)
        setupAction()
    }
    init(firstTitle: String, secondTitle: String,thirdTitle: String) {
        super.init(frame: .zero)
    
        
        firstButton.setTitle(firstTitle, for: .normal)
        secondButton.setTitle(secondTitle, for: .normal)
        thirdButton.setTitle(thirdTitle, for: .normal)
        currentCount = 3
        setupView(currentCount)
        setupAction()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup function
    private func setupView(_ count:Int) -> Void {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        if count == 2 {
            addSubview(bottomView)
            bottomView.snp.makeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.right.equalTo(snp.centerX)
                make.bottom.equalToSuperview()
            }

            addSubview(firstButton)
            firstButton.snp.makeConstraints { (make) in
                make.height.equalTo(40)
                make.left.top.bottom.equalToSuperview()
                make.right.equalTo(snp.centerX)
            }
            addSubview(secondButton)
            secondButton.snp.makeConstraints { (make) in
                make.height.equalTo(40)
                make.right.top.bottom.equalToSuperview()
                make.left.equalTo(snp.centerX)
            }
            }
        else {
            addSubview(bottomView)
            addSubview(firstButton)
            addSubview(secondButton)
            addSubview(thirdButton)
            
            bottomView.snp.makeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.33)
//                make.height.equalTo(40)
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
        if currentCount == 2 {
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.right.equalTo(self.snp.centerX)
                make.height.equalTo(2)
     
            }
            self.superview?.layoutIfNeeded()
        }
        }
        else {
            UIView.animate(withDuration: 0.3) {
                self.bottomView.snp.remakeConstraints { (make) in
                    make.bottom.equalToSuperview()
                    make.width.centerX.equalTo(self.firstButton)
                    make.height.equalTo(2)
                  }
                self.superview?.layoutIfNeeded()
            }
        }
        firstAction?()
    }
    
    func secondButtonSelected() -> Void {
        selectedButton = secondButton
        if currentCount == 2{
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.height.equalTo(2)
                make.right.bottom.equalToSuperview()
                make.left.equalTo(self.snp.centerX)
            }
            self.superview?.layoutIfNeeded()
        }
        }
        else{
            UIView.animate(withDuration: 0.3) {
                self.bottomView.snp.remakeConstraints { (make) in
                    make.bottom.equalToSuperview()
                    make.width.centerX.equalTo(self.secondButton)
                    make.height.equalTo(2)
                }
                self.superview?.layoutIfNeeded()
          }
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
