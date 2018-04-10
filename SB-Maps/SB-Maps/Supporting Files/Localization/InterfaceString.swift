//
//  InterfaceString.swift
//  Raven
//
//  Created by Kerry Knight on 9/28/16.
//  Copyright © 2017 JOMO, Inc. All rights reserved.
//

import Foundation

public struct InterfaceString {
    static let OK: String = NSLocalizedString("OK", comment: "")
    
    public struct Selection {
        static let Work: String = NSLocalizedString("Go to Work", comment: "")
        static let Vacation: String = NSLocalizedString("Go on Vacation", comment: "")
    }
    
    public struct Map {
        static let CurrentLocation: String = NSLocalizedString("Current Location", comment: "")
        static let ErrorTitle: String = NSLocalizedString("Error Finding Location", comment: "")
        static let LocationDeniedTitle: String = NSLocalizedString("Location Disabled", comment: "")
        static let LocationDeniedMessage: String = NSLocalizedString("Please enable location permissions in your device's settings.", comment: "")
    }
}
