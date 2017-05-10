//
//  Location.swift
//  RainyShiny
//
//  Created by Suru Layé on 5/4/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance =  Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
