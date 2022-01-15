////
////  SplashViewController.swift
////  SaparLine
////
////  Created by Aldiyar Massimkhanov on 11/10/20.
////  Copyright © 2020 thousand.com. All rights reserved.
////
//
//import UIKit
//class SplashViewController: ScrollViewController {
//
//    private lazy var foregroundSplashWindow: UIWindow = {
//        let splashViewController = self.splashViewController(with: textImage)
//        let splashWindow = self.splashWindow(windowLevel: .normal + 1, rootViewController: splashViewController)
//        
//        return splashWindow
//    }()
//
//    private func splashWindow(windowLevel: UIWindow.Level, rootViewController: SplashViewController?) -> UIWindow {
//        let splashWindow = UIWindow(frame: UIScreen.main.bounds)
//        
//        splashWindow.windowLevel = windowLevel
//        splashWindow.rootViewController = rootViewController
//        
//        return splashWindow
//    }
//    
//    private func splashViewController(with textImage: UIImage?) -> SplashViewController? {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController")
//        
//        let splashViewController = viewController as? SplashViewController
//        splashViewController?.textImage = textImage
//
//        return splashViewController
//    }
//
//    
//    lazy var appImage: UIImageView = {
//        let image = UIImageView()
//        image.image = #imageLiteral(resourceName: "1024")
////        image.layer.cornerRadius = 32
//        image.layer.masksToBounds = true
//        return image
//    }()
//
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//    }
//    
//    // MARK: - SetupViews
//    func setupViews() -> Void {
//        scrollView.addSubviews([appImage])
//        appImage.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(100)
//            make.centerX.equalToSuperview()
//        }
//    }
//    
//}
//
//protocol SplashPresenterDescription: class {
//    func present()
//    func dismiss(completion: @escaping () -> Void)
//}
//
//final class SplashPresenter: SplashPresenterDescription {
//     func present() {
//        // Пока оставим метод пустым
//     }
//     
//    func dismiss(completion: @escaping () -> Void) {
//        // Пока оставим метод пустым
//    }
//}
