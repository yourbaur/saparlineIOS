//
//  AdditionalDatesView.swift
//  SaparLine
//
//  Created by Rustem Madigassymov on 11/20/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class AdditionalDatesView: UIView {
    
    // MARK: - Properties
    lazy var datesLabel: UILabel = {
        let label = UILabel()
        label.text = localized(text: "additionalDates")
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.tag = 0
        if #available(iOS 13.4, *) { picker.preferredDatePickerStyle = .wheels }
        picker.minimumDate = Date()
        picker.datePickerMode = .dateAndTime
        picker.addTarget(self, action: #selector(tapDate(sender:)), for: .valueChanged)
        return picker
    }()
    lazy var datePicker2: UIDatePicker = {
        let picker = UIDatePicker()
        picker.tag = 1
        if #available(iOS 13.4, *) { picker.preferredDatePickerStyle = .wheels }
        picker.minimumDate = Date()
        picker.datePickerMode = .dateAndTime
        picker.addTarget(self, action: #selector(tapDate(sender:)), for: .valueChanged)
        return picker
    }()
    lazy var fromDateView: DefaultTextField = {
        let view = DefaultTextField()
        view.text = localized(text: "chooseDepartureDate")
        view.imageProfile.image = #imageLiteral(resourceName: "calendar 1")
        view.rightImage.image = #imageLiteral(resourceName: "feather_chevron-right")
        view.actionButton.isHidden = true
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        view.inputView = datePicker
        return view
    }()
    lazy var toDateView: DefaultTextField = {
        let view = DefaultTextField()
        view.text = localized(text: "chooseArrivalDate")
        view.imageProfile.image = #imageLiteral(resourceName: "calendar 1")
        view.rightImage.image = #imageLiteral(resourceName: "feather_chevron-right")
        view.actionButton.isHidden = true
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        view.inputView = datePicker2
        return view
    }()
    lazy var deleteButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "delete"), for: .normal)
        btn.addTarget(self, action: #selector(tapDelete), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Init
    required init?(coder: NSCoder) { fatalError("")}
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        invalidateIntrinsicContentSize()
        
        addSubviews([datesLabel, fromDateView, toDateView, deleteButton])
        datesLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
        }
        fromDateView.snp.makeConstraints { (make) in
            make.top.equalTo(datesLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        toDateView.snp.makeConstraints { (make) in
            make.top.equalTo(fromDateView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalTo(toDateView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        var size = CGSize()
        size.height = 200
        return size
    }
    
    // MARK: - actions
    @objc func tapDate(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        if sender.tag == 0 {
            fromDateView.text = formatter.string(from: datePicker.date)
        } else {
            toDateView.text = formatter.string(from: datePicker2.date)
        }
    }
    @objc func tapDelete() {
        datesLabel.removeFromSuperview()
        fromDateView.removeFromSuperview()
        toDateView.removeFromSuperview()
        deleteButton.removeFromSuperview()
        removeFromSuperview()
    }
}
