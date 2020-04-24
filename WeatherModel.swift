//
//  WeatherModel.swift
//  Clima
//
//  Created by Rahul Kumar on 24/04/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let weatherId: Int
    let temperature: Float
    let cityName: String
    var temperatureString: String {
        return String(format: "%.2f", temperature)
    }
    var conditionName: String {
        switch weatherId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
