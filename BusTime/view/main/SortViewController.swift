//
//  FilterViewController.swift
//  SaparLine
//
//  Created by Bauyrzhan on 28.02.2021.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit

protocol SortDelegate {
    func send(sortType:String)
}

class SortViewController: UIViewController {
    var tapType:String?
    var sortArray: [String] = ["По рейтингу"]
    var delegate: SortDelegate? = nil
    
        
    // MARK: - Properties
    lazy var mainView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        btn.addTarget(self, action: #selector(tapMain), for: .touchUpInside)
        return btn
    }()
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SortTableViewCell.self, forCellReuseIdentifier: SortTableViewCell.cellIdentifier())
        table.delegate = self
        table.dataSource = self
        table.layer.cornerRadius = 9
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) { fatalError("") }
    init(tapType:String) {
        self.tapType = tapType
        super.init(nibName: nil, bundle: nil)
        
    }
    
    // MARK: - Setup
    func setupViews() -> Void {
        view.backgroundColor = .clear
        
        view.addSubviews([mainView, tableView])
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc func tapMain() -> Void {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Tableview delegate
extension SortViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sortArray.count ?? 0)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SortTableViewCell.cellIdentifier(), for: indexPath) as! SortTableViewCell
        cell.label.text = sortArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.send(sortType: sortArray[indexPath.row])
        dismiss(animated: true, completion: nil)
        
    }
}
