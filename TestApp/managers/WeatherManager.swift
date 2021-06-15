//
//  WeatherManager.swift
//  TestApp
//
//  Created by Ivan Oliferovich on 4/21/21.
//

import Foundation

import MapKit


class WeatherManager {

    static let shared = WeatherManager()
    private init() { }

    private let apiAccessKey = "3a5edcd15576a17cdf175469a6372cd3"
    private let apiUrl = "http://api.openweathermap.org/data/2.5/weather?units=metric&"

    func sendRequest(coordinates: CLLocationCoordinate2D, completion: @escaping (WeatherData?) -> ()) {

        let latilude = coordinates.latitude
        let longitude = coordinates.longitude

        let urlString = "\(apiUrl)lat=\(latilude)&lon=\(longitude)&APPID=\(apiAccessKey)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
                do {
                    let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(weather)
                } catch {
                    completion(nil)
                }
            } else {
                print(error?.localizedDescription ?? "sendRequest error")
                completion(nil)
            }
        }
        task.resume()
    }
}
