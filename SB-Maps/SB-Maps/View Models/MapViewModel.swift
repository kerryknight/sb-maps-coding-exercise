//
//  MapViewModel.swift
//  SB-Maps
//
//  Created by Kerry Knight on 4/10/18.
//  Copyright © 2018 Kerry Knight. All rights reserved.
//

import Foundation
import CoreLocation

class MapViewModel: NSObject {
    let location: LocationSelection
    let regionRadius: CLLocationDistance = 1000
    
    init(location: LocationSelection) {
        log.debug("location: \(location)")
        self.location = location
        super.init()
    }
}

// MARK: - Public Methods
extension MapViewModel {
    public func titleText() -> String {
        switch location {
        case .cancun:
            return "To Cancún, Mexico"
        case .newYork:
            return "To New York, NY"
        }
    }
}
