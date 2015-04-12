//
//  WeatherService.swift
//  Today
//
//  Created by ilteris on 4/12/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//


import CoreLocation
import Foundation
import UIKit

protocol ForecastIO {
    func currentWeatherData(weather:CurrentWeather)
    func failedGettingCurrentData()
}


class WeatherService: NSObject {
    private let API_KEY = "f16eee6b1d2b74580f38750e03ea836c";
  
    var delegate: ForecastIO?
    
    override init() {
        super.init()
        
    }
    



    func getCurrentWeatherData(lon:String, lat:String) -> Void {
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(API_KEY)/")
        
        let forecastURL = NSURL(string: "\(lon),\(lat)", relativeToURL:baseURL)

        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if(error == nil) {
                let dataObject = NSData(contentsOfURL: location)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as! NSDictionary
                
                let currentWeather = CurrentWeather(weatherDictionary: weatherDictionary)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                  self.delegate?.currentWeatherData(currentWeather)
                })
            }  else {
               self.delegate?.failedGettingCurrentData()
                
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                   UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
            }
        })
        downloadTask.resume()
        }
}


