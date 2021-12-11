import Foundation
import UIKit

enum MyError: Error {
    case postsNotFound
    case photosNotFound
    
    func addAlert() -> UIAlertController {
        switch self {
        case .postsNotFound:
            let alert = UIAlertController(title: "Ошибка", message: "Новости не найдены", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alert.addAction(alertButton)
            return alert
        case .photosNotFound:
            let alarm = UIAlertController(title: "Ошибка!", message: "Не получилось загрузить фотографии", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alarm.addAction(alertButton)
            return alarm
        }
    }
}
