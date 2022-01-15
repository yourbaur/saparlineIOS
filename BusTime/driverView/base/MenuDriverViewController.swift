//
//  MenuDriverViewController.swift
//  BusTime
//
//  Created by greetgo on 8/25/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import LGSideMenuController

class MenuDriverViewController: UIViewController {

    var model: UserDetail? {
        didSet {
            if model?.avatar != nil {
                let url = model?.avatar?.serverUrlString.url
                userImage.kf.setImage(with: url)
            }
            nameTitle.text = (model?.name ?? "Введите") + " " + (model?.surname ?? "")
        }
    }
    
    // MARK: - variables
    lazy var layer0: CAGradientLayer = {
        let layer0 = CAGradientLayer()
        layer0.colors = [UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1).cgColor,UIColor(red: 0.294, green: 0.424, blue: 0.718, alpha: 1).cgColor]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.9, y: 0.7)
        layer0.bounds = view.bounds.insetBy(dx: -0.5 * view.bounds.size.width, dy: -0.5 * view.bounds.size.height)
        layer0.position = view.center
        return layer0
    }()
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.addSublayer(layer0)
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - properties
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "feather_x"), for: .normal)
        button.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
        return button
    }()
    lazy var userImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Group 10534"))
        image.layer.cornerRadius = 32
        image.layer.masksToBounds = true
        return image
    }()
    lazy var profileButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(tapProfile), for: .touchUpInside)
        return btn
    }()
    lazy var welcomeTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "welcome")
        label.textColor = .white
        label.font = UIFont.init(name: Font.mullerRegular, size: 18)
        return label
    }()
    lazy var nameTitle: UILabel = {
        let label = UILabel()
        label.text = "Ivan Ivanov"
        label.textColor = .white
        label.font = UIFont.init(name: Font.mullerMedium, size: 20)
        return label
    }()
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(MenuDriverTableViewCell.self, forCellReuseIdentifier: MenuDriverTableViewCell.cellIdentifier())
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.isScrollEnabled = false
        return table
    }()
    lazy var beCustomerTitle: UILabel = {
        let label = UILabel()
        label.text = localized(text: "bePass")
        label.textColor = .white
        label.font = UIFont.init(name: Font.mullerBold, size: 15)
        return label
    }()
    lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = maincolor.blue
        switcher.addTarget(self, action: #selector(tapSwitcher), for: .valueChanged)
        return switcher
    }()

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
        setupViews()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
    }
    
    // MARK: - setup
    func setupViews() -> Void {
        view.addSubviews([mainView])
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        mainView.addSubviews([closeButton,userImage,profileButton,welcomeTitle,
                              nameTitle,tableView,beCustomerTitle,switcher])
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(43)
            make.right.equalToSuperview().offset(-22)
            make.width.height.equalTo(28)
        }
        userImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(124)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(64)
        }
        profileButton.snp.makeConstraints { (make) in
            make.top.equalTo(userImage.snp.top)
            make.width.equalToSuperview()
            make.bottom.equalTo(userImage.snp.bottom)
        }
        welcomeTitle.snp.makeConstraints { (make) in
            make.left.equalTo(userImage.snp.right).offset(12)
            make.centerY.equalTo(userImage.snp.centerY).offset(-10)
        }
        nameTitle.snp.makeConstraints { (make) in
            make.left.equalTo(userImage.snp.right).offset(12)
            make.centerY.equalTo(userImage.snp.centerY).offset(10)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(userImage.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(150)
        }
        beCustomerTitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-90)
        }
        switcher.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switcher.snp.makeConstraints { (make) in
            make.centerY.equalTo(beCustomerTitle.snp.centerY)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - actions
    @objc func refresh() {
        if UserManager.shared.isSessionActive() {
            getProfile()
        }
    }
    @objc func tapClose() -> Void {
        self.sideMenuController?.hideLeftView(animated: true, completionHandler: nil)
    }
    @objc func tapProfile() -> Void {
        let vc = ProfileDriverViewController()
        sideMenuController?.hideLeftView(animated: true, completionHandler: {
            (self.sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
        })
    }
    @objc func tapSwitcher() -> Void {
        if switcher.isOn == true {
            self.showSubmitMessage(messageType: .null, localized(text: "surePass")) {
                self.bePassenger()
            }
        }
        switcher.isOn = false
    }
}

// MARK: - table delegate
extension MenuDriverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuDriverTableViewCell.cellIdentifier(), for: indexPath) as! MenuDriverTableViewCell

        switch indexPath.row {
        case 0: cell.title.text = localized(text: "main")
            cell.iconImageView.image = #imageLiteral(resourceName: "home")
        case 1: cell.title.text = localized(text: "comingRides")
            cell.iconImageView.image = #imageLiteral(resourceName: "zondicons_travel-case")
        case 2: cell.title.text = localized(text: "addBus")
            cell.iconImageView.image = #imageLiteral(resourceName: "raphael_bus")
        case 3: cell.title.text = localized(text: "myPass")
            cell.iconImageView.image = #imageLiteral(resourceName: "fa-solid_users")
        case 4: cell.title.text = localized(text: "travelHis")
            cell.iconImageView.image = #imageLiteral(resourceName: "Group-2")
        case 5:
            cell.title.text = localized(text: "contacts")
            cell.iconImageView.image = #imageLiteral(resourceName: "phone-call")
            cell.iconImageView.image = cell.iconImageView.image?.withRenderingMode(.alwaysTemplate)
            cell.iconImageView.tintColor = .white
        default:
            break
        }
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            if model?.confirmation == "waiting" {
                showErrorMessage(messageType: .none, "Ожидайте, Админ проверяет ваши данные!")
                let vc = UnconfirmedProfileDriverViewController()
                self.sideMenuController?.hideLeftView(animated: true, completionHandler: {
                    (self.sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
                })
            } else {
                let vc = MainDriverViewController(carId: nil, countPlaces: nil, carTypeId: nil)
                self.sideMenuController?.hideLeftView(animated: true, completionHandler: {
                    (self.sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
                })
            }
        case 1:
            let vc = ComingTripsViewController(carId:nil)
            sideMenuController?.hideLeftView(animated: true, completionHandler: {
                (self.sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            })
        case 2:
            let vc = AddTransportViewController()
            sideMenuController?.hideLeftView(animated: true, completionHandler: {
                (self.sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            })
        case 3:
            let vc = MyPassengersViewController(carId: nil)
            sideMenuController?.hideLeftView(animated: true, completionHandler: {
                (self.sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            })
        case 4:
            let vc = HistoryOrdersDriverViewController()
            sideMenuController?.hideLeftView(animated: true, completionHandler: {
                (self.sideMenuController?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            })
        case 5:
            let phoneNumber =  "77071909009"
            let appURL = URL(string: "https://wa.me/\(phoneNumber)")!
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            }
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

// MARK: - parser
extension MenuDriverViewController {
    private func getProfile() -> Void {
        let parameter = ["id": UserManager.shared.getCurrentUser()!.user!.id] as Parameters
        ParseManager.shared.getRequest(url: api.getById, parameters: parameter) { (result: UserDetail?, error) in
            if let error = error {
                //self.showErrorMessage(messageType: .error, error)
                print(error)
            } else {
                if let result = result {
                    self.model = result
                }
            }
        }
    }
    private func bePassenger() -> Void {
        showHUD()
        ParseManager.shared.postRequest(url: api.bePassenger) { (result: CheckRequest?, error) in
            self.dismissHUD()
            UserManager.shared.setTypeUser(withArray: "passenger")
            self.showSuccessMessage {
                AppCenter.shared.startCustomer()
            }
        }
    }
}
