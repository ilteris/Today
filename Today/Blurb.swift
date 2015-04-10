//
//  Blurb.swift
//  Today
//
//  Created by ilteris on 4/10/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import Foundation
class Blurb {
    var date:String
    var summary:String
    var temperature:Double
    var weatherIcon:String
    var location:String
    
    init(date:String, summary:String, temperature:Double, weatherIcon:String, location:String) {
        self.date = date
        self.summary = summary
        self.temperature = temperature
        self.weatherIcon = weatherIcon
        self.location = location
    }
}