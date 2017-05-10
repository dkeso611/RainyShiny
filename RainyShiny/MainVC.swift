//
//  ViewController.swift
//  RainyShiny
//
//  Created by Suru Layé on 5/2/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

/*
 Notes: Tableview add tableview delegate and datadsource. In viewDidLoad, delegate and data source = self
 Use tableview functions - numberOfSections, numberOfRows and cellForRow
 
 */

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
//    var forecast: Forecast!
    var forecastArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy =  kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
                
        currentWeather = CurrentWeather()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getLocation()
    }
    
    func getLocation() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherData {
                self.downloadForecastData {
                    self.updateUI()
                }
            }
            
            print(currentLocation)
            
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            getLocation()
        }
        
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: DAILY_FORECAST_URL)!
        print(forecastURL)
        
        Alamofire.request(forecastURL).responseJSON { response in
            
            //Using SwiftyJSON
            switch response.result {
            case .success(let value):
//                let resultDictionary = JSON(value).dictionaryObject
//                print(resultDictionary!)
//                
//                if let list = resultDictionary?["list"] as? [Dictionary<String, AnyObject>] {
//
//                    for obj in list {
//                        let forecast = Forecast(weatherDict: obj)
//                        self.forecastArray.append(forecast)
//                    }
//                }
                
                let result = JSON(value)
                
                if let list = result["list"].arrayObject {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj as! Dictionary<String, AnyObject>)
                        self.forecastArray.append(forecast)
//                        print(obj)
                    }
                    
                }
                self.forecastArray.remove(at: 0)
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell {
            
            let forecast = forecastArray[indexPath.row]
            
            cell.configureCell(forecast: forecast)
            
            if indexPath.row == 0 {
                cell.dayLabel.text = "Tomorrow"
            }
            return cell
        }
        return WeatherTableViewCell()
    }
    
    func updateUI() {
        
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)°"
        locationLabel.text = currentWeather.cityName
        currentWeatherLabel.text = currentWeather.weatherType
        currentWeatherImageView.image = UIImage(named: currentWeather.weatherType)

//        print(currentWeather.date)
//        print(currentWeather.currentTemp)
//        print(currentWeather.cityName)
//        print(currentWeather.weatherType)

        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

