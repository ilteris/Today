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
    
    var currentWeather = (temperature:"", summary:"", iconString:"")

    class var sharedInstance: BlurbsManager {
        struct Static {
            static let instance: BlurbsManager = BlurbsManager()
        }
        return Static.instance
    }
    
    override init() {
        
        
    }
    
   
    
}
