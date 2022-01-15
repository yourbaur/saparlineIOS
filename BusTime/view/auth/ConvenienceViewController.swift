//
//  ConvenienceViewController.swift
//  BusTime
//
//  Created by greetgo on 9/7/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

protocol ConvenienceViewControllerDelegate: class {
    func convenienceTitle(convenienceTitle: String)
}

class ConvenienceViewController: UIViewController {

    weak var delegate: ConvenienceViewControllerDelegate?
    private var convenienceTitleArray = ["Телевизор","Кондиционер","Багаж"]
    private var convenienceTitle = ""
    
    // MARK: - Properties
    lazy var quesTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = localized(text: "facilitiesQuestion")
        label.textColor = maincolor.blue
        label.font = UIFont.init(name: Font.mullerBold, size: 27)
        label.textAlignment = .center
        return label
    }()
    lazy var justTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.text = localized(text: "facilitiesText")
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        label.textAlignment = .center
        return label
    }()
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ConvenienceTableViewCell.self, forCellReuseIdentifier: ConvenienceTableViewCell.cellIdentifier())
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    lazy var addButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "addButton"), for: .normal)
        btn.addTarget(self, action: #selector(tapAdd), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setup
    func setupViews() -> Void {
        view.addSubviews([quesTitle,justTitle,addButton,tableView])
        quesTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(42)
            make.right.equalToSuperview().offset(-42)
        }
        justTitle.snp.makeConstraints { (make) in
            make.top.equalTo(quesTitle.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        addButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(43)
            make.right.equalToSuperview().offset(-43)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(justTitle.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.bottom.equalTo(addButton.snp.top).offset(-10)
        }
    }
    
    // MARK: - Actions
    @objc func tapAdd() -> Void {
        delegate?.convenienceTitle(convenienceTitle: convenienceTitle)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableView delegate
extension ConvenienceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return convenienceTitleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConvenienceTableViewCell.cellIdentifier(), for: indexPath) as! ConvenienceTableViewCell
        cell.titleLabel.text = convenienceTitleArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ConvenienceTableViewCell
        cell.itemSelected = !cell.itemSelected
        cell.itemSelected == true ? (cell.iconImage.image = #imageLiteral(resourceName: "Frame 36")) : (cell.iconImage.image = #imageLiteral(resourceName: "Frame 36-1"))
        tableView.deselectRow(at: indexPath, animated: true)
        if convenienceTitle == "" {
            convenienceTitle = convenienceTitleArray[indexPath.row]
        } else {
            convenienceTitle += ", \(convenienceTitleArray[indexPath.row])"
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
