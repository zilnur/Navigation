import Foundation
import UserNotifications
import UIKit

class LocalNotificationsService: NSObject {
    
    let center = UNUserNotificationCenter.current()
    
    func registeForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        center.requestAuthorization(options: [.badge, .provisional, .sound]) { bool, error in
            if bool {
                let content = UNMutableNotificationContent()
                self.center.removeAllPendingNotificationRequests()
                content.sound = .default
                content.title = "Новое сообщение"
                content.body = "Посмотрите последние обновления"
                content.badge = 1
                content.categoryIdentifier = "updates"
                var components = DateComponents()
                components.hour = 18
                components.minute = 05
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                let request = UNNotificationRequest(identifier: "1", content: content, trigger: trigger)
                self.center.add(request)
                print("OK")
            } else if let error = error {
                print(error)
            }
        }
    }
    
}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
    
    func registerUpdatesCategory() {
        center.delegate = self
        
        let actionShow = UNNotificationAction(identifier: "update", title: "Update", options: .authenticationRequired)
        let category = UNNotificationCategory(identifier: "updates", actions: [actionShow], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("OK")
        case "update":
            print("OK")
        default:
            break
        }
        completionHandler()
    }
}
