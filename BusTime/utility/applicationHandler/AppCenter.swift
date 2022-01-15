
//
//  LTGas
//  Created by Tuigynbekov Yelzhan on 1/28/20.
//  Copyright © 2020 Tuigynbekov Yelzhan. All rights reserved.
//

import UIKit
import LGSideMenuController

class AppCenter {
    
    // MARK: - Variables
    static let shared = AppCenter()
    private var window: UIWindow = UIWindow()
    
    // MARK: - Functions
    func createWindow(_ window: UIWindow) -> Void {
        self.window = window
    }
    private func makeKeyAndVisible() -> Void {
        window.makeKeyAndVisible()
        window.backgroundColor = .white
    }
    private func setRootController(_ controller: UIViewController) -> Void {
        window.rootViewController = controller
    }

    // MARK: - App Start
    //Auth
    func startAuth() -> Void {
        makeKeyAndVisible()
        setRootController(LoginViewController().inNavigation())
    }
    func startNoInternet() {
        makeKeyAndVisible()
        setRootController(NoInternetViewController().inNavigation())
    }
    
    //Customer
    func startCustomer() -> Void {
        makeKeyAndVisible()
        makeRootController()
    }
    func makeRootController() -> Void {
        setRootController(setupMenuViewController())
    }
    
    func startCustomerTickets() -> Void {
        makeKeyAndVisible()
        makeRootController()
    }
    
    func makeNotRootController(type:String, carId:String?=nil) -> Void {
        if type == "driver" {
            setRootController(setupPassengersMenuViewController())
        }
        else if type == "feedback" {
            if (UserManager.shared.getTypeUser() ?? "") == "driver" {
                setRootController(setupFeedbackMenuViewController(carId: Int(carId ?? "0") ?? 0))
            }
        }
        else {
            if (UserManager.shared.getTypeUser() ?? "") != "driver"{
                setRootController(setupTicketMenuViewController())
            }
        }
    }
    
    func setupTicketMenuViewController() -> UIViewController {
        let vc = TicketsViewController().inNavigation()
        let sideMenuController = LGSideMenuController.init(rootViewController: vc,
                                                           leftViewController: MenuViewController(),rightViewController: nil)
        sideMenuController.leftViewWidth = UIScreen.main.bounds.width * 0.85;
        sideMenuController.leftView?.alpha = 1

        return sideMenuController
    }
    
    func setupPassengersMenuViewController() -> UIViewController {
        let vc = MyPassengersViewController(carId: nil).inNavigation()
        let sideMenuController = LGSideMenuController.init(rootViewController: vc,
                                                           leftViewController: MenuDriverViewController(),rightViewController: nil)
        sideMenuController.leftViewWidth = UIScreen.main.bounds.width * 0.85;
        sideMenuController.leftView?.alpha = 1

        return sideMenuController
    }
    func setupFeedbackMenuViewController(carId:Int) -> UIViewController {
        let vc = ReviewViewController(carId:carId).inNavigation()
        let sideMenuController = LGSideMenuController.init(rootViewController: vc,
                                                           leftViewController: MenuDriverViewController(),rightViewController: nil)
        sideMenuController.leftViewWidth = UIScreen.main.bounds.width * 0.85;
        sideMenuController.leftView?.alpha = 1

        return sideMenuController
    }
   
    func setupMenuViewController() -> UIViewController {
        let vc = MainViewController().inNavigation()
        let sideMenuController = LGSideMenuController.init(rootViewController: vc,
                                                           leftViewController: MenuViewController(),rightViewController: nil)
        sideMenuController.leftViewWidth = UIScreen.main.bounds.width * 0.85;
        sideMenuController.leftView?.alpha = 1

        return sideMenuController
    }
    //Driver
    func startDriver() -> Void {
        makeKeyAndVisible()
        driverMakeRootController()
    }
    func driverMakeRootController() -> Void {
        setRootController(driverSetupMenuViewController())
    }
    func driverSetupMenuViewController() -> UIViewController {
        let vc = MainDriverViewController(carId: nil, countPlaces: nil, carTypeId: nil).inNavigation()
        let sideMenuController = LGSideMenuController.init(rootViewController: vc,
                                                           leftViewController: MenuDriverViewController(),rightViewController: nil)
        sideMenuController.leftViewWidth = UIScreen.main.bounds.width * 0.85;
        sideMenuController.leftView?.alpha = 1
        return sideMenuController
    }
}
