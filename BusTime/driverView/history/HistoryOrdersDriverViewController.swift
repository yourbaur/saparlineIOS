//
//  HistoryOrdersViewController.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class HistoryOrdersDriverViewController: BaseDriverViewController {

    // MARK: - Variables
    var travelListArray: [TravelList]?
    
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(HistoryOrdersDriverTableViewCell.self, forCellReuseIdentifier: HistoryOrdersDriverTableViewCell.cellIdentifier())
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
        title = localized(text: "travelHis")
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold,size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
//        let filterButton = UIBarButtonItem(image:  #imageLiteral(resourceName: "Group-9").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(tapFilter))
//        navigationItem.rightBarButtonItem = filterButton
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getTravelList()
        setupViews()
    }

    // MARK: - SetupViews
    func setupViews() -> Void {
        view.addSubviews([tableView, emptyLabel])
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    func isEmptyData() {
        if travelListArray?.count == 0 {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
    
    // MARK: - Actions
    @objc func tapFilter() -> Void {
        navigationController?.pushViewController(FilterCalendarViewController(), animated: true)
    }
}

// MARK: - TableView delegate
extension HistoryOrdersDriverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelListArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryOrdersDriverTableViewCell.cellIdentifier(), for: indexPath) as! HistoryOrdersDriverTableViewCell
        cell.selectionStyle = .none
        cell.configure(model: (travelListArray![indexPath.row]))
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
extension HistoryOrdersDriverViewController {
    private func getTravelList() -> Void {
        showHUD()
        
        ParseManager.shared.getRequest(url: api.travelListDriver, parameters: nil) { (result: [TravelList]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .none, error)
                return
            } else {
                guard let res = result else { return }
                self.travelListArray = res
                self.isEmptyData()
                self.tableView.reloadData()
            }
        }
    }
}
