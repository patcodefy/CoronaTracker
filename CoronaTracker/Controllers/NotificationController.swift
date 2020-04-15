//
//  NotificationController.swift
//  CoronaTracker
//
//  Created by pat on 4/14/20.
//  Copyright © 2020 pat. All rights reserved.
//

import Foundation
import UserNotifications
class NotificationController {
    
    func notification() {
           let center = UNUserNotificationCenter.current()
           let content = UNMutableNotificationContent()
           
           content.title = "COVID-19"
           content.subtitle = "Corona virus updates"
           content.body = "Open the app to get updated tracking information about CoronaVirus"
           content.sound = UNNotificationSound.default
           content.threadIdentifier = "covid-19"
           
           var dateComponent = DateComponents()
        
           dateComponent.hour = 8
           dateComponent.minute = 0
           dateComponent.second = 0
        
           let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
           let request = UNNotificationRequest(identifier: "covid-19", content: content, trigger: trigger)
        
           center.add(request){ (error) in
               if error != nil {
                   print (error!)
               }
               
           }
       }
}
