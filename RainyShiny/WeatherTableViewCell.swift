//
//  WeatherTableViewCell.swift
//  RainyShiny
//
//  Created by Suru Layé on 5/3/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

  
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(forecast: Forecast) {
        lowTempLabel.text = "\(forecast.lowTemp)°"
        highTempLabel.text = "\(forecast.highTemp)°"
        dayLabel.text = forecast.date
        weatherTypeLabel.text = forecast.weatherType
        weatherIconImageView.image = UIImage(named: "\(forecast.weatherType)")
        
    }

}
