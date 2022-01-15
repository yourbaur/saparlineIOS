

//
//  Created by Tuigynbekov Yelzhan on 1/28/20.
//  Copyright © 2020 Tuigynbekov Yelzhan. All rights reserved.
//

import UIKit
import MBProgressHUD
import SVProgressHUD

enum AlertMessageType: String {
    case error = "Ошибка"
    case none = "Внимание"
    case null = ""
    case confirm = "Вам только что позвонили"}


extension UIViewController {
    func showMessage(_ message: String? = nil) {
        SVProgressHUD.showInfo(withStatus: message)
        SVProgressHUD.dismiss(withDelay: 1)
    }
    func inNavigation() -> UIViewController {
        return UINavigationController(rootViewController: self)
    }
    func add(_ child: UIViewController, onView aView: UIView) {
        addChild(child)
        aView.addSubview(child.view)
        child.view.snp.makeConstraints { (make) in
            make.edges.equalTo(aView)
        }
        child.didMove(toParent: self)
    }
    func remove() {
        guard parent != nil else {return}
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    func showSubmitMessage(messageType: AlertMessageType, _ message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: messageType.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Да", style: .default) { (action) in
            if let completionHandler = completion {
                self.dismiss(animated: true, completion: nil)
                completionHandler()
            }
        }

        let cancelAction = UIAlertAction(title: "Нет", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
            UserManager.shared.setConfirm(to: false)
            
        }

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    func showErrorMessage(messageType: AlertMessageType, _ message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: messageType.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let completionHandler = completion {
                self.dismiss(animated: true, completion: nil)
                completionHandler()
            }
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showSuccessMessage(completion: (() -> ())? = nil) -> Void {
        let alertController = UIAlertController(title: "Успешно", message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                alertController.dismiss(animated: true) {
                    if let completionHandler = completion {
                        completionHandler()
                    }
                }
            }
        })
    }
    func showSuccessMessageForReserve(completion: (() -> ())? = nil) -> Void {
        let alertController = UIAlertController(title: "Ваш заказ принят", message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                alertController.dismiss(animated: true) {
                    if let completionHandler = completion {
                        completionHandler()
                    }
                }
            }
        })
    }

    func showHUD() -> Void {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    func dismissHUD() -> Void {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    func localized(text: String) -> String {
        let lang = LanguageCenter.standard.getLanguage() ?? "ru"
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj") {
            let bundle = Bundle(path: path)
            return NSLocalizedString(text, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
       return NSLocalizedString(text, comment: "")
    }
}


extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
extension UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}


extension UIView {
    func addShadow(_ radius: CGFloat = 20.0) {
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.7
    }
    func addSubviews(_ views : [UIView]) -> Void {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
    func addShadow(with color: UIColor, radius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.8
        layer.cornerRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
    }
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    func localized(text: String) -> String {
        let lang = LanguageCenter.standard.getLanguage() ?? "ru"
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj") {
            let bundle = Bundle(path: path)
            return NSLocalizedString(text, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
       return NSLocalizedString(text, comment: "")
    }
}


extension UIImageView {
    func setImage(_ url: String) -> Void {
        if let url = url.url {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    self.image = image
                } else {
                    setPlaceholder()
                }
            } else {
                setPlaceholder()
            }
        } else {
            setPlaceholder()
        }
    }
    func setPlaceholder() -> Void {
        let notFoundImageUrl = URL(string: "https://images.immediate.co.uk/production/volatile/sites/3/2017/11/imagenotavailable1-39de324.png?quality=90&resize=768,574")!

        if let data = try? Data(contentsOf: notFoundImageUrl) {
            if let image = UIImage(data: data) {
                self.image = image
            }
        }
    }
}


extension String {
    var serverUrlString: String {
        return "http://194.4.56.241:8888/" + self
    }
    var url: URL? {
        return URL(string: self)
    }
    func getDate(_ format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: self)
    }
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    func onlyDate() -> String {
        return String(self.prefix(10))
    }
    func onlyTime() -> String {
        let array = Array(self)
        if array.count > 16 {
            return String(array[11..<16])}
        else {
            return ""
        }
    }
    func makeCall() -> Void {
        print("Phone:", self)
        
        let number = URL(string: "tel://" + self)!
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
}


extension Date {
    var generalDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let string = dateFormatter.string(from: self)

        return string
    }
    var currentTime: (hour: Int, minute: Int, time: String) {
        let date = Date()

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        let hourString = hour > 9 ? String(hour) : "0\(hour)"
        let minuteString = minute > 9 ? String(minute) : "0\(minute)"

        return (hour, minute, "\(hourString):\(minuteString)")
    }
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
}


public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone13,1":                              return "iPhone 12 mini"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,3":                              return "iPhone 12 Pro"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
            case "iPhone14,4":                              return "iPhone 13 mini"
            case "iPhone14,5":                              return "iPhone 13"
            case "iPhone14,2":                              return "iPhone 13 Pro"
            case "iPhone14,3":                              return "iPhone 13 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

extension UIButton {
    func addRightIcon(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)

        let length = CGFloat(15)
        let width = CGFloat(30)
        titleEdgeInsets.left += length

        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: self.titleLabel!.leadingAnchor, constant: -7),
            imageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: length)
        ])
    }
}
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
