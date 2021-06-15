//
//  WeatherData.swift
//  TestApp
//
//  Created by Ivan Oliferovich on 4/21/21.
//

import Foundation


struct WeatherData: Decodable {
    var coord: Coordinates
    var weather: [Weather]
    var name: String
    var main: Main
    var base: String
    var wind: Wind
    var clouds: Clouds

}
struct Coordinates: Decodable {
    var lon: Double
    var lat: Double
}

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
}

struct Main: Decodable {
    var temp: Double
    var pressure: Int
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
    var feels_like: Double
}

struct Wind: Decodable {
    var speed: Double
    var deg: Int
}

struct Clouds: Decodable {
    var all: Int
}
