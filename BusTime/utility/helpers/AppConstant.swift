
import Foundation
import UIKit

enum api {
    // MARK: - Профиль
    static let auth                = "profile/login"
    static let register            = "profile/register"
    static let phoneConfirm        = "profile/phone-confirmation"
    static let confirm             = "profile/confirmation"
    static let addBus              = "profile/addCar"
    static let carsList            = "profile/cars"
    static let getById             = "user/getById"
    static let edit                = "profile/edit"
    static let restoreSMS          = "profile/password-reset/send"
    static let restoreNewPass      = "profile/password-reset/check"
    
    // MARK: - Пассажир
    static let travelListPassenger = "travel/list"               //список транспортов
    static let myTicketsPassenger  = "my-tickets-groupped"                //мои билеты
    static let placeCancel         = "travel/place/cancel"       //возварт билета
    static let orderHistories      = "order-histories"           //список поездок
    static let placeReserve        = "travel/place/reservation"  //бронь места
    static let beDriver            = "profile/role/driver"       //стать водителем
    
    // MARK: - Водитель
    static let travelAdd           = "travel/add"                //опубликовать автобус(json massive)
    static let travelUpComingId    = "profile/carTravels"
    static let travelUpComing      = "travel/upcoming"           //грядущие поездки
    static let travelListDriver    = "travel/histories"          //история поездок
    static let myPassengers        = "travel/my-passengers"      //мои пассажиры
    static let myPassengersGroup   = "travel/my-passengers-groupped"
    static let bePassenger         = "profile/role/passenger"    //стать пассажиром
    static let travelDelete        = "travel/delete"             //удалить поездку (заявку)
    static let reserveEdit         = "travel/place/edit"
    static let settings            = "setting"
    
    //reviews
    static let addReview           = "toFeedback"
    static let listReviews         = "feedback/list"
    //редактировать резерв
    
    // MARK: - Общая
    static let travelShowPassenger = "travel/show"//детали транспорта
    static let call = "call"
    
    // MARK: - Прочие
    static let cartypes            = "carTypes"
    static let cities              = "cities"
    static let stations            = "stations"
    static let travelStations      = "travel-stations"
    static let policy              = "setting"                   //Политика конфиденциальности
}

enum Font {
    static let mullerMedium  = "MullerMedium"
    static let mullerRegular = "MullerRegular"
    static let mullerBold    = "MullerBold"
    static let mullerBlack   = "MullerBlack"
}

enum maincolor {
    static let blue = UIColor(red: 0.161, green: 0.243, blue: 0.424, alpha: 1)
    static let lightgray = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
}
