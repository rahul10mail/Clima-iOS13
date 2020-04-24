//
//  WeatherManager.swift
//  Clima
//
//  Created by Rahul Kumar on 24/04/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5c47629e872cd4e3ed94d9fa4b38c536&units=metric"
    
    var delegate: WeatherManagerDelegate?
    func fetchWeather(_ city: String) {
        let cityURL = "\(weatherURL)&q=\(city)"
        performRequest(cityURL)
    }
    
    func fetchWeather(latitude: Double, longitude: Double) {
        let cityURL = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(cityURL)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(data: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let city = decodedData.name
            let temperature = decodedData.main.temp
            let weather = WeatherModel(weatherId: id, temperature: temperature, cityName: city)
    
            return weather
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
        
    }
}
