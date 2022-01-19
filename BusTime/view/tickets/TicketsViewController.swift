//
//  TicketsViewController.swift
//  BusTime
//
//  Created by Tuigynbekov Yelzhan on 8/16/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit

class TicketsViewController: BaseViewController {
    
    // MARK: - Variables
    var array = [MyTicketsModel?]()

    // MARK: - Properties
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(TicketsTableViewCell.self, forCellReuseIdentifier: TicketsTableViewCell.cellIdentifier())
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
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
        title = localized(text: "myTickets")
        navigationController?.navigationBar.tintColor = maincolor.blue
        navigationController?.navigationBar.barTintColor = maincolor.blue
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyTickets()
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
    
    // MARK: - Actions
    @objc func tapReturn(button: UIButton) -> Void {
        showSubmitMessage(messageType: .none, localized(text: "returnTicket")) {
            self.cancelPlace(placeId: button.tag)
            self.getMyTickets()
        }
    }
}

// MARK: - TableView delegate
extension TicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TicketsTableViewCell.cellIdentifier(), for: indexPath) as! TicketsTableViewCell
        cell.selectionStyle = .none
        cell.ticketImage.isUserInteractionEnabled = true
        cell.returnButton.addTarget(self, action: #selector(tapReturn(button:)), for: .touchUpInside)
        cell.configure(model: array[indexPath.row]!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
}

// MARK: - Parser
extension TicketsViewController {
    private func getMyTickets() -> Void {
        showHUD()
        ParseManager.shared.getRequest(url: api.myTicketsPassenger) { (result: [MyTicketsModel]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .error, error)
                return
            }
            self.array = result ?? [MyTicketsModel]()
            self.isEmptyData()
            self.tableView.reloadData()
        }
    }
    private func cancelPlace(placeId: Int) -> Void {
        showHUD()
        let parameter: [String: Any] = ["place_id": placeId]
        ParseManager.shared.postRequest(url: api.placeCancel, parameters: parameter) { (result: CheckRequest?, error) in
            self.dismissHUD()
//            if let error = error {
//                print(error)
//                self.showErrorMessage(messageType: .none, error)
//                return
//            }
            self.showSuccessMessage()
        }
    }
}
