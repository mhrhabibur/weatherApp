//
//  WeatherModel.swift
//  Weather App
//
//  Created by Habibur Rahman on 2/6/22.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let conditionId: Int
    
    var weatherCondition: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 800:
            return "sun.and.horizon.fill"
        case 800...804:
            return "cloud.fill"
        default:
            return "cloud.sun.fill"
        }
    }
    
    
    
    
}
