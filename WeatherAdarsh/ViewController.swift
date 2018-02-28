//
//  ViewController.swift
//  WeatherAdarsh
//
//  Created by Adarsh Sinha on 24/02/18.
//  Copyright © 2018 Adarsh Sinha. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var city: UILabel!
    var forecastData = [Weather]()
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temp: UILabel!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        print("hi")
        
        
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0{
            locationManager.startUpdatingLocation()
            locationManager.delegate = nil
            print("longittude = \(location.coordinate.longitude) and latitude = \(location.coordinate.latitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            //enter your dark sky api key here 
            let basePathURL = "https://api.darksky.net/forecast/KEY/"
            let urlRequest = basePathURL + "\(latitude),\(longitude)"
            print(urlRequest)
            getData(urL: urlRequest)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                if error != nil{
                    return
                }
                let pm = placemarks![0] as CLPlacemark!
                let city = pm?.locality
                self.city.text = city
            })
        }
    }
    func getData(urL:String){
        let request = URLRequest(url: URL(string:urL)!)
        let session = URLSession.shared
       session.dataTask(with: request) { (data, response, error) in
        if let data = data{
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                let json = JSON(jsonData)
                self.updateView(json: json)
            }
            catch{
                
            }
        }
        }.resume()
        
    }
    func updateView(json:JSON){
        let Type = json["daily"]["icon"].stringValue
        let tmp = json["currently"]["temperature"].double
        let tp = Int((tmp!-32)*(5/9))
        let model = WeatherJSON( type: Type, temp: String(tp))
        DispatchQueue.main.async {
            self.temp.text = model.temperataure + " Celsius"
            self.type.text = model.type
            self.icon.image = UIImage(named:model.type)
            
            
            if self.type.text == "rain" {
                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "rainy-wall")!)
            }
            if self.type.text == "clear-day" {
                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "summer-wall")!)
            }
            if self.type.text == "Mostly Cloudy" {
                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "winter-wall")!)
            }
           
            
        }
        
        
       
        
    }
}

//RANDOMS
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        //guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//     //   print("locations = \(locValue.latitude) \(locValue.longitude)")
////        let latitude: CLLocationDegrees = (self.locationManager.location?.coordinate.latitude)!
////        let longitude: CLLocationDegrees = (self.locationManager.location?.coordinate.longitude)!
////        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
//        print("hi2")
//        let location = locations[locations.count - 1]
////        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
////
////            if error != nil {
////                print("error -- failed ")
////                return
////                if (placemarks?.count)! > 0 {
////                    let pm = placemarks?[0] as CLPlacemark!
////                    let city = (pm?.locality)!
////                    let basePathURL = "https://api.darksky.net/forecast/5f164ab236210591a3fa70f863049d63/"
////                    let url = basePathURL + "\(locValue.latitude),\(locValue.longitude)"
////                  // let weatherObject = self.forecastData[indexpath.row]
////                    self.city.text = city
////                              //  self.summary.text = forecastArray["summary"] as? [String:AnyObject]
////                        }    }
////            }
//        //if location.horizontalAccuracy > 0{
//            locationManager.startUpdatingLocation()
//            locationManager.delegate = nil
//            print("longittude = \(location.coordinate.longitude) and latitude = \(location.coordinate.latitude)")
//            let latitude = String(location.coordinate.latitude)
//            let longitude = String(location.coordinate.longitude)
//            let basePathURL = "https://api.darksky.net/forecast/5f164ab236210591a3fa70f863049d63/"
//            let urlRequest = basePathURL + "\(latitude),\(longitude)"
//            getData(urL: urlRequest)
//       // }
//}

//    func view(){
//    }

