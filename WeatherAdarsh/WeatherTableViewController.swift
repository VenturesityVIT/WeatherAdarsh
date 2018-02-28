//
//  WeatherTableViewController.swift
//  WeatherAdarsh
//
//  Created by Adarsh Sinha on 24/02/18.
//  Copyright © 2018 Adarsh Sinha. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var forecastData = [Weather]()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
       
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let locationString = searchBar.text, !locationString.isEmpty {
            //update the weather for location entered by the user
            updateWeatherForLocation(location: locationString)
            
        
        }
        
    }
    
    func updateWeatherForLocation (location: String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if error == nil {
                if let location = placemarks?.first?.location {
                    Weather.forecast(withLocation: location.coordinate, completion: { (results: [Weather]?) in
                        
                        if let weatherData = results {
                            self.forecastData = weatherData
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                        
                    })
                    
                }
                
                
            }
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return forecastData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd / MM / YYYY"
        
        return dateFormatter.string(from: date!)
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        
        let weatherObject = forecastData[indexPath.section]
         //Configure the cell...
        cell.textLabel?.text = weatherObject.summary
        cell.detailTextLabel?.text = "\(Int(weatherObject.temperature))" + " Farhenheit"
        cell.imageView?.image = UIImage(named: weatherObject.icon)

        return cell
    }
 

    }
