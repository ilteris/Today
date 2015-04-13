//
//  BlurbsManager.swift
//  Today
//
//  Created by ilteris on 4/10/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import Foundation
import Realm

class BlurbsManager: NSObject {
    
    var blurbDates = [RLMResults]()
    var currentWeather = (temperature:"", summary:"", iconString:"")

    var blurbDate:BlurbDate = BlurbDate()
    

    
    class var sharedInstance: BlurbsManager {
        struct Static {
            static let instance: BlurbsManager = BlurbsManager()
        }
        return Static.instance
    }
    
    
    override init() {
        
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        
        
        
        
        
//            Blurb(date: "3:20pm", summary: "Had a bad dream.", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
//            Blurb(date: "12:20am", summary: "We saw our friend Natalie!", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
//            Blurb(date: "8:20am", summary: "School Started.", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
//            Blurb(date: "2:20am", summary: "I went to movies!", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
//            Blurb(date: "3:20pm", summary: "Had a bad dream.", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
//            Blurb(date: "12:20am", summary: "We saw our friend Natalie!", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
//            Blurb(date: "8:20am", summary: "School Started.", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
//            Blurb(date: "2:20am", summary: "I went to movies!", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),

       
        
      
        
    }
    
   
    
}
