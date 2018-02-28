//
//  CurrentLocationTableViewController.swift
//  WeatherAdarsh
//
//  Created by Adarsh Sinha on 26/02/18.
//  Copyright © 2018 Adarsh Sinha. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var forecastData = [Weather]()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.locationManager.requestWhenInUseAuthorization()
//
//        self.locationManager.requestAlwaysAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self as! CLLocationManagerDelegate
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//
//
//
    }
    
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            //   print("locations = \(locValue.latitude) \(locValue.longitude)")
            
            //        let latitude: CLLocationDegrees = (self.locationManager.location?.coordinate.latitude)!
            //        let longitude: CLLocationDegrees = (self.locationManager.location?.coordinate.longitude)!
            
            let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
            
            
            
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                
                if error != nil {
                    print("error -- failed ")
                    return
                }
                
                if (placemarks?.count)! > 0 {
                    let pm = placemarks?[0] as CLPlacemark!
                    let city = (pm?.locality)!
                    
                    
                }
            }
        }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
