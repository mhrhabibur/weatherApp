//
//  ViewController.swift
//  Weather App
//
//  Created by Habibur Rahman on 2/6/22.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var CityLabel: UILabel!
    @IBOutlet var weatherCondition: UIImageView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var cityNameLabel: UILabel!
    
    var locationManager: CLLocationManager!
    

    var weatherManager = WeatherManager()
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }


    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
    }
    

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if searchTextField.text == "" || searchTextField.text == nil{
            searchTextField.placeholder = "Enter city name"
            cityNameLabel.text = ""
            
        } else {
            if let city = searchTextField.text {
                weatherManager.fetchData(cityName: city) { weather, error in
                    if let myWeather = weather {
                        
                        let temp = myWeather.main.temp
                        let city = String(myWeather.name)
                        let conditionID = myWeather.weather[0].id
                        
                        let wet = WeatherModel(cityName: city, temperature: temp, conditionId: conditionID)
                        let temperature = String(format:"%.1f", wet.temperature)
                        DispatchQueue.main.async {
                            self.cityNameLabel.text = "\(temperature)°C"
                            self.weatherCondition.image = UIImage(systemName: wet.weatherCondition)
                            self.CityLabel.text = String(wet.cityName)
                        }
                    }
                }
            }
        }
        
        searchTextField.text = ""
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        // print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        if  latitude == locValue.latitude &&
                longitude == locValue.longitude {
            return
        }
        latitude = locValue.latitude
        longitude = locValue.longitude
        
        weatherManager.fetchDataAutomatically(latitude: latitude, longitude: longitude) { weather, error in
            if let myWeather = weather {
                
                let temp = myWeather.main.temp
                let city = String(myWeather.name)
                let conditionID = myWeather.weather[0].id
                
                let wet = WeatherModel(cityName: city, temperature: temp, conditionId: conditionID)
                let temperature = String(format:"%.1f", wet.temperature)
                DispatchQueue.main.async {
                    self.cityNameLabel.text = "\(temperature)°C"
                    self.weatherCondition.image = UIImage(systemName: wet.weatherCondition)
                    self.CityLabel.text = String(wet.cityName)
                }
            }
        }
    }
}


        
        
        
        
      
    


