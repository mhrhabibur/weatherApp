//
//  WeatherManager.swift
//  Weather App
//
//  Created by Habibur Rahman on 2/6/22.
//

import Foundation

class WeatherManager {
   

    func fetchData(cityName: String, completion: @escaping (WeatherMapping?, Error?) -> Void) {
       if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=1f462dda351a1f36c3d8b29280ef0fdb&q=\(cityName)")
        {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            if let data = data {
                do {
                let weather = try JSONDecoder().decode(WeatherMapping.self, from: data)

                    completion(weather, nil)

                   
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
       }
        
    }
    
    
    
}

