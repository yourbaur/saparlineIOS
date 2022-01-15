//
//  Coordinator.swift
//  SaparLine
//
//  Created by Admin on 1/18/21.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {

    static let shared = Coordinator()

    private init() {}

    private var currentController: UIViewController = UIViewController()

    func setCurrentViewController(_ controller: UIViewController) -> Void {
        self.currentController = controller
    }

    func getCurrentViewController() -> UIViewController {
        return currentController
    }

    func push(_ viewController: UIViewController) -> Void {
        if let navigationController = currentController.tabBarController?.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            currentController.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func pop() -> Void {
        if let navigationController = currentController.tabBarController?.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            currentController.navigationController?.popViewController(animated: true)
        }
    }

    func show(_ viewController: UIViewController, presentStyle: UIModalPresentationStyle = .fullScreen) -> Void {
        viewController.modalPresentationStyle = presentStyle
        if let tabBarController = currentController.tabBarController {
            tabBarController.present(viewController, animated: true, completion: nil)
        } else if let navigationController = currentController.navigationController {
            navigationController.present(viewController, animated: true, completion: nil)
        } else {
            currentController.present(viewController, animated: true, completion: nil)
        }
    }

    func dismiss(completion: (() -> ())? = nil) {
        if let tabBarController = currentController.tabBarController {
            tabBarController.dismiss(animated: true, completion: completion)
        } else if let navigationController = currentController.navigationController {
            navigationController.dismiss(animated: true, completion: completion)
        } else {
            currentController.dismiss(animated: true, completion: completion)
        }
    }

   
}
