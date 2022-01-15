//
//  ConvenienceSimpleViewController.swift
//  SaparLine
//
//  Created by Rustem Madigassymov on 11/18/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

protocol ConvenienceSimpleViewControllerDelegate: class {
    func convenienceTitle(convenienceTitle: String)
}

class ConvenienceSimpleViewController: UIViewController {

    weak var delegate: ConvenienceSimpleViewControllerDelegate?
    private var convenienceTitleArray = ["Телевизор","Кондиционер","Багаж"]
    private var convIsSelected = [false, false, false]
    private var convenienceTitle = ""
    
    // MARK: - Properties
    lazy var mainView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        btn.addTarget(self, action: #selector(tapMain), for: .touchUpInside)
        return btn
    }()
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ConvenienceTableViewCell.self, forCellReuseIdentifier: ConvenienceTableViewCell.cellIdentifier())
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = 9
        return table
    }()
    lazy var addButton: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle(localized(text: "done"), for: .normal)
        btn.addTarget(self, action: #selector(tapAdd), for: .touchUpInside)
        return btn
    }()
    lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 9
        return container
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) { fatalError("") }
    init() { super.init(nibName: nil, bundle: nil) }
    
    // MARK: - Setup
    func setupViews() -> Void {
        view.addSubviews([mainView, container])
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        container.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(280)
        }
        container.addSubviews([tableView,addButton])
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.width.equalToSuperview()
        }
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom).offset(30)
            make.left.equalTo(tableView.snp.left).offset(30)
            make.right.equalTo(tableView.snp.right).offset(-30)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    // MARK: - Actions
    @objc func tapMain() -> Void {
        dismiss(animated: true, completion: nil)
    }
    @objc func tapAdd() -> Void {
        for i in 0...convIsSelected.count-1 {
            if convIsSelected[i] {
                if convenienceTitle == "" {
                    convenienceTitle = convenienceTitleArray[i]
                } else {
                    convenienceTitle += ", \(convenienceTitleArray[i])"
                }
            }
        }
        delegate?.convenienceTitle(convenienceTitle: convenienceTitle)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView delegate
extension ConvenienceSimpleViewController: UITableViewDelegate, UITableViewDataSource {
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
        convIsSelected[indexPath.row] = cell.itemSelected
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
