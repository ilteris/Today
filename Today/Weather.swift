//
//  Weather.swift
//  Today
//
//  Created by ilteris on 4/10/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import Foundation
class Weather {
    let icon:String
    let temperature:Double
    let location:String
    
    init(icon:String, temperature:Double, location:String) {
        self.icon = icon
        self.temperature = temperature
        self.location = location
    }

}