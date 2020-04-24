//
//  WeatherManager.swift
//  Clima
//
//  Created by Rahul Kumar on 24/04/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5c47629e872cd4e3ed94d9fa4b38c536&units=metric"
    
    func fetchWeather(_ city: String) {
        let cityURL = "\(weatherURL)&q=\(city)"
        performRequest(cityURL)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handler(data:urlResponse:error:))
            task.resume()
        }
    }
    
    func handler(data: Data?, urlResponse: URLResponse?, error: Error?) -> Void {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            parseJSON(data: safeData)
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let city = decodedData.name
            let temperature = decodedData.main.temp
            let weather = WeatherModel(weatherId: id, temperature: temperature, cityName: city)
            print(weather.temperatureString)
        } catch {
            print(error)
        }
        
    }
}
