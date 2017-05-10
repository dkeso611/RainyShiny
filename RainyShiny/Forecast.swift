//
//  Forecast.swift
//  RainyShiny
//
//  Created by Suru Layé on 5/4/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: Double!
    var _lowTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return "\(String(format: "%g", _highTemp))"
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return "\(String(format: "%g", _lowTemp!))"
    }
    
    
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let minK = temp["min"] as? Double {
                let minF =  Double(round(minK * (9/5) - 459.67))
                self._lowTemp = minF
            }
            
            if let maxK = temp["max"] as? Double {
                let maxF =  Double(round(maxK * (9/5) - 459.67))
                self._highTemp = maxF
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            self._date = unixConvertedDate.dayOfTheWeek()
            
         }
        
    }

}

extension Date {
    func dayOfTheWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
