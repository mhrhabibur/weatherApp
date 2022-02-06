//
//  Weather.swift
//  Weather App
//
//  Created by Habibur Rahman on 2/6/22.
//

import Foundation

struct WeatherMapping: Decodable {
    let main: Main
    let name: String
    let weather: [Weather]
}


struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
