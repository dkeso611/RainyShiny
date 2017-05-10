//
//  CurrentWeather.swift
//  RainyShiny
//
//  Created by Suru Layé on 5/3/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

/*
 Allow non https sites. Go to plist, App Transfert Protocol, All arbitrary loads
 */

import UIKit
import Alamofire
import SwiftyJSON


class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today is \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        
        return "\(String(format: "%g", _currentTemp))"
    }
    
    
    //DownloadComplete is a typealias for () -> ()
    func downloadWeatherData(completed: @escaping DownloadComplete) {
        
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        print(currentWeatherURL)
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            
            //Using SwiftyJSON
            switch response.result {
            case .success(let value):
                let resultDictionary = JSON(value)
                
                if let name = resultDictionary["name"].string{
                    self._cityName = name
                    print(self._cityName)
                }
                
                if let main = resultDictionary["weather"][0]["main"].string {
                    self._weatherType = main.capitalized
                    print(self._weatherType)
                }

                if let tempK =  resultDictionary["main"]["temp"].double {
                    let tempF = Double(round(tempK * (9/5) - 459.67))
                    self._currentTemp = tempF
                    print(self._currentTemp)
                }
                
                
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
    
    
}

