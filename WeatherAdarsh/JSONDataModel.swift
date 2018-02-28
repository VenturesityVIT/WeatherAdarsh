//
//  JSONDataModel.swift
//  WeatherAdarsh
//
//  Created by Sarvad shetty on 2/27/18.
//  Copyright © 2018 Adarsh Sinha. All rights reserved.
//

import Foundation
struct WeatherJSON {
    //var city:String
    var type:String
    var temperataure:String
    init(type:String,temp:String) {
       
        self.type = type
        self.temperataure = temp
    }

}
