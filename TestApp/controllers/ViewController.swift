//
//  ViewController.swift
//  TestApp
//
//  Created by Ivan Oliferovich on 4/21/21.
//


import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(revealRegionDetails(sender:)))
                mapView.addGestureRecognizer(recognizer)
    }

    @IBAction func revealRegionDetails(sender: UITapGestureRecognizer) {
            let touchLocation = sender.location(in: mapView) // получить координакы на экране
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView) // преобразуем координаты экрана в координатя карты

            print("Tapped at:\nlat: \(locationCoordinate.latitude)\nlong: \(locationCoordinate.longitude)")

            WeatherManager.shared.sendRequest(coordinates: locationCoordinate) { weather in
                DispatchQueue.main.async {
                    let point = MKPointAnnotation()
                    point.coordinate = locationCoordinate
                    if let weather = weather {
                        point.title = "temp: \(weather.main.temp)\nfeels like: \(weather.main.feels_like)"
                        point.subtitle = "temp_max: \(weather.main.temp_max)\ntemp_min: \(weather.main.temp_min)"
                    } else {
                        point.title = "error data"
                    }
                    self.mapView.addAnnotation(point)
                }
            }
        }

}
