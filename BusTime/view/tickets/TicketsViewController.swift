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
      
//        cell.ticketImage.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 0.6226455479)
        
        cell.returnButton.addTarget(self, action: #selector(tapReturn(button:)), for: .touchUpInside)
        cell.configure(model: array[indexPath.row]!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
        //
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
        //UITableView.automaticDimension
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
            self.array = self.getArray(original: result!)
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
    
    //function to get array maximum four places in one ticket
    private func getArray(original: [MyTicketsModel]) -> [MyTicketsModel?] {
        //open new generated array
        var newArray: [MyTicketsModel] = []
        for ticket in original {
            let numberCount = ticket.number?.count ?? 1
            //if count of places is less than 4, just append it
            if (numberCount)<4 {
                newArray.append(ticket)
            }
            //else generate by yourself
            else {
                var numberArray: [Int] = []
                for number in 0..<numberCount {
                    let placeNumber = (ticket.number ?? [Int]())[number]
                    // if element is not first and divide by four append new element and clear numberArray
                    if (number+1)%4 == 0 && number != 0 {
                        var ticketModel = MyTicketsModel()
                        ticketModel.configure(model: ticket)
                        ticketModel.number = numberArray
                        newArray.append(ticketModel)
                        
                        numberArray = []
                        numberArray.append(placeNumber)
                    }
                    
                    // if it is last element append last array of the number
                    else if number + 1 == numberCount {
                        var ticketModel = MyTicketsModel()
                        ticketModel.configure(model: ticket)
                        ticketModel.number = numberArray
                        newArray.append(ticketModel)
                    }
                    
                    // else just append number of place
                    else {
                        numberArray.append(placeNumber)
                    }
                }
            }
        }
        //return new array
        return newArray
    }
}
