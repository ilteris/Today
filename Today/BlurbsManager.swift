//
//  BlurbsManager.swift
//  Today
//
//  Created by ilteris on 4/10/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import Foundation

class BlurbsManager {
    
    var blurbs = [Blurb]()
    
    class var sharedInstance: BlurbsManager {
        struct Static {
            static let instance: BlurbsManager = BlurbsManager()
        }
        return Static.instance
    }
    
    
    init() {
        blurbs =  [
            Blurb(date: "23-2-2012", summary: "I see bla", temperature: 12.3, weatherIcon: "cloudy", location: "New York")
        ]
    }
}
