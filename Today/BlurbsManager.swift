//
//  BlurbsManager.swift
//  Today
//
//  Created by ilteris on 4/10/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import Foundation

class BlurbsManager: NSObject {
    
    var blurbs = [Blurb]()
    var connection: YapDatabaseConnection?

    
    class var sharedInstance: BlurbsManager {
        struct Static {
            static let instance: BlurbsManager = BlurbsManager()
        }
        return Static.instance
    }
    
    
    override init() {
        
        var paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        var baseDir = paths.count > 0 ? paths[0] as! String : NSTemporaryDirectory() as String
        var database = YapDatabase(path: baseDir.stringByAppendingPathComponent("YapDatabase.sqlite"))
        connection = database.newConnection()
        
        
        blurbs =  [
            Blurb(date: "3:20pm", summary: "Had a bad dream.", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
            Blurb(date: "12:20am", summary: "We saw our friend Natalie!", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
            Blurb(date: "8:20am", summary: "School Started.", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
            Blurb(date: "2:20am", summary: "I went to movies!", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
            Blurb(date: "3:20pm", summary: "Had a bad dream.", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
            Blurb(date: "12:20am", summary: "We saw our friend Natalie!", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
            Blurb(date: "8:20am", summary: "School Started.", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),
            Blurb(date: "2:20am", summary: "I went to movies!", temperature: 12.3, weatherIcon: "cloudy", location: "New York"),

        ]
        
      
        
    }
    
   
    
}
