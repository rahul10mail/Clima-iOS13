//
//  WeatherData.swift
//  Clima
//
//  Created by Rahul Kumar on 24/04/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Float
    let humidity: Float
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}
