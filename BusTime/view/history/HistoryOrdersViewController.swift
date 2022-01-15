//
//  HistoryOrdersViewController.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class HistoryOrdersViewController: BaseViewController {

    // MARK: - Variables
    var array = [OrderHistoriesModel?]()
    
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(HistoryOrdersTableViewCell.self, forCellReuseIdentifier: HistoryOrdersTableViewCell.cellIdentifier())
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        return table
    }()
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = localized(text: "emptyList")
        label.textColor = .gray
        label.backgroundColor = .clear
        label.font = UIFont.init(name: Font.mullerRegular, size: 16)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        title = localized(text: "hisOrders")
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold,
                                                                                                            size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getOrders()
        setupViews()
    }

    // MARK: - SetupViews
    private func setupViews() -> Void {
        view.addSubviews([tableView, emptyLabel])
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    private func isEmptyData() {
        if array.count == 0 {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
}

// MARK: - TableView delegate
extension HistoryOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryOrdersTableViewCell.cellIdentifier(), for: indexPath) as! HistoryOrdersTableViewCell
        cell.selectionStyle = .none
        cell.configure(model: array[indexPath.row]!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Parser
extension HistoryOrdersViewController {
    private func getOrders() -> Void {
        showHUD()
        ParseManager.shared.getRequest(url: api.orderHistories) { (result: [OrderHistoriesModel]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .error, error)
                return
            }
            self.array = result!
            self.isEmptyData()
            self.tableView.reloadData()
        }
    }
}
