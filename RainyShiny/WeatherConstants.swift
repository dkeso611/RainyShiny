//
//  WeatherConstants.swift
//  RainyShiny
//
//  Created by Suru Layé on 5/3/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

import Foundation


typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=98fed6e261e18aa59aa3855495e2736a"

let DAILY_FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)1&lon=\(Location.sharedInstance.longitude!)&appid=98fed6e261e18aa59aa3855495e2736a"

