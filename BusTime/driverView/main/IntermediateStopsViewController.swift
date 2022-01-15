//
//  IntermediateStopsViewController.swift
//  BusTime
//
//  Created by greetgo on 8/28/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit // не ползуюсь
class IntermediateStopsViewController: ScrollViewController {

    var stationsArray: [StationsModel2]?
    var statID: Int?
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    
    // MARK: - Properties
    lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Выберите из списка точки остановки"
        label.textColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        label.font = UIFont.init(name: Font.mullerRegular, size: 14)
        return label
    }()
    lazy var intermediateView: PriceView = {
        let view = PriceView(leftIcon: #imageLiteral(resourceName: "fa-solid_map-pin"), title: "Промежуточные остановки", rightIcon: #imageLiteral(resourceName: "feather_chevron-right"))
        view.field.inputView = pickerView
        return view
    }()
    lazy var priceView = CustomDriverView(leftIcon: #imageLiteral(resourceName: "Frame 21"), title: "Цена до остановки", rightIcon: #imageLiteral(resourceName: "feather_chevron-right"))
    lazy var plusButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.init(name: Font.mullerMedium, size: 35)
        btn.backgroundColor = UIColor(red: 0.887, green: 0.927, blue: 0.993, alpha: 1)
        btn.layer.cornerRadius = 20
        btn.isHidden = true
        return btn
    }()
    lazy var saveBtn: DefaultButton = {
        let btn = DefaultButton()
        btn.setTitle("Сохранить", for: .normal)
        return btn
    }()
    
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        title = "Промежуточные остановки"
        navigationController?.navigationBar.tintColor = .white
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: Font.mullerBold, size: 18)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1)
        view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    // MARK: - Init
    required init?(coder: NSCoder) {fatalError("")}
    init(fromID: Int, toID: Int) {
        super.init(nibName: nil, bundle: nil)
        
        getTravelStations(fromID: fromID, toID: toID)
    }
    
    
    // MARK: - SetupViews
    func setupViews() -> Void {
        view.addSubviews([topTitle,intermediateView,priceView,plusButton,saveBtn])
        topTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(16)
        }
        intermediateView.snp.makeConstraints { (make) in
            make.top.equalTo(topTitle.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        priceView.snp.makeConstraints { (make) in
            make.top.equalTo(intermediateView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        plusButton.snp.makeConstraints { (make) in
            make.top.equalTo(priceView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        saveBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}


//  MARK: - picker delegate
extension IntermediateStopsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {return 1}
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stationsArray?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stationsArray![row].stations
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        intermediateView.field.text = stationsArray![row].stations
        statID = stationsArray![row].station_id
    }
}


// MARK: - Parser
extension IntermediateStopsViewController {
    private func getTravelStations(fromID: Int, toID: Int) -> Void {
        self.showHUD()
        let parameter = ["from_city_id": fromID,
                         "to_city_id": toID]
        ParseManager.shared.getRequest(url: api.travelStations, parameters: parameter) { (result: [StationsModel2]?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .error, error); return
            }
            self.stationsArray = result!
            
        }
    }
}
