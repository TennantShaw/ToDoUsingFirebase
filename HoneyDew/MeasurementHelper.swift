//
//  MeasurementHelper.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/23/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Firebase

class MeasurementHelper: NSObject {
    static func sendLoginEvent() {
        Analytics.logEvent(AnalyticsEventLogin, parameters: nil)
    }
    
    static func sendLogoutEvent() {
        Analytics.logEvent("logout", parameters: nil)
    }
    
    static func sendMessageEvent() {
        Analytics.logEvent("message", parameters: nil)
    }
}
