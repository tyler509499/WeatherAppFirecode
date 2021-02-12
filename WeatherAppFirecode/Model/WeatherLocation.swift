//
//  WeatherLocation.swift
//  WeatherAppFirecode
//
//  Created by Galkov Nikita on 10.02.2021.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
   }
    
}
