//
//  FilterCalendarViewController.swift
//  BusTime
//
//  Created by greetgo on 8/24/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import FSCalendar

protocol FilterCalendarDelegate {
    func sendDate(date: String)
    func sendDataMain(tag: Int, date: String)
}

class FilterCalendarViewController: UIViewController {

    var delegate: FilterCalendarDelegate? = nil
    var dateString: String = ""
    var tag: Int?
    
    // MARK: - Properties
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.locale = Locale(identifier: "RU")
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.selectionColor = .white
        calendar.appearance.todayColor = .clear
        calendar.headerHeight = 60
        calendar.appearance.titleSelectionColor = #colorLiteral(red: 0.1607843137, green: 0.2431372549, blue: 0.4235294118, alpha: 1)
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.weekdayTextColor = .white
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.todayColor = .red
        return calendar
    }()
    lazy var applyButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "apply"), for: .normal)
        btn.setTitleColor(maincolor.blue, for: .normal)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(tapApply), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = localized(text: "filter")
        navigationController?.navigationBar.tintColor = .white
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        view.backgroundColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    
    // MARK: - Initialization
    required init?(coder: NSCoder) {fatalError("")}
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    init(tag: Int) {
        super.init(nibName: nil, bundle: nil)
        self.tag = tag
    }
    
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        view.addSubviews([calendar, applyButton])
        calendar.snp.makeConstraints { (make) in
            make.height.equalTo(280)
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview()
        }
        applyButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
        }
    }
    
    
    // MARK: - Actions
    @objc func tapApply() -> Void {
        tag == nil ? delegate?.sendDate(date: dateString) : delegate?.sendDataMain(tag: tag!, date: dateString)
        navigationController?.popToRootViewController(animated: true)
    }
}


// MARK: - Calendar delegate
extension FilterCalendarViewController : FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dateString = date.generalDateString
    }
}
