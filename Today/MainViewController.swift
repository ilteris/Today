//
//  ViewController.swift
//  Today
//
//  Created by ilteris on 4/10/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import UIKit
import Snap


class MainViewController: UIViewController, UITableViewDataSource, CurrentLocation, ForecastIO {

    let kCellId = "blurbCell"
    

    let tableView = UITableView(frame: CGRectZero, style: .Plain)

    let bottomView:UIImageView =   {
        let view = UIImageView(image: UIImage(named: "bottom_bg"))
        view.backgroundColor = UIColor.clearColor()
        return view
    }()
    
    lazy var weatherView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Left
        return label
        }()
    
    let iconView:UIImageView =   {
        let view = UIImageView()
        view.backgroundColor = UIColor.clearColor()
        return view
        }()
    
    lazy var whatHappenedText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 35)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.text = "WHAT HAPPENED TODAY?"
        label.numberOfLines = 2

        label.layer.shadowColor = UIColor.blackColor().CGColor
        label.layer.shadowOffset = CGSizeMake(1, 1)
        label.layer.shadowOpacity = 0.4;
        label.layer.shadowRadius = 2;
   
        
        return label
        }()
    
    
    
    let locationService = LocationService()
    let weatherService = WeatherService()
    
    
    convenience init()
    {
        self.init(nibName: nil, bundle: nil)
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        let superview = view
        
     //   superview.addSubview(UIImageView(image: UIImage(named: "Reference")))

        
        
        superview.addSubview(tableView)
        superview.addSubview(bottomView)
        superview.addSubview(weatherView)
        superview.addSubview(iconView)
        superview.addSubview(whatHappenedText)
        
        tableView.dataSource = self
        
        tableView.rowHeight = 80
        tableView.snp_makeConstraints { make in
            make.width.equalTo(superview.snp_width)
            make.bottom.equalTo(superview.snp_centerY)
            make.top.equalTo(0)
            make.left.equalTo(0)
        }
        
        bottomView.snp_makeConstraints { make in
            make.width.equalTo(superview.snp_width)
            make.top.equalTo(self.tableView.snp_bottom).offset(-8)
            make.left.equalTo(0)
        }
        
        
        
        iconView.snp_makeConstraints { make in
            make.top.equalTo(self.bottomView.snp_top).offset(20)
            make.left.equalTo(10)
        }

        
        
        
        weatherView.snp_makeConstraints { make in
            make.left.equalTo(self.iconView.snp_right).offset(20)
            make.centerY.equalTo(self.iconView.snp_centerY)

        }
        
        whatHappenedText.snp_makeConstraints { make in
            make.width.equalTo(self.view.snp_width)
            make.centerY.equalTo(self.bottomView.snp_centerY)
            make.centerX.equalTo(self.bottomView.snp_centerX)
            
        }
        
        
        
        
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BlurbsManager.sharedInstance.blurbs.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let blurb = BlurbsManager.sharedInstance.blurbs[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("blurbCell") as! BlurbTableCell
        cell.backgroundColor = UIColor.clearColor()

        cell.setBlurbSummary(blurb)

        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationService.delegate = self

        
        tableView.registerClass(BlurbTableCell.classForCoder(), forCellReuseIdentifier: kCellId)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        

        //set the delegate here.
       

        
        
        for familyName in UIFont.familyNames() {
            if let fn = familyName as? String {
                for font in UIFont.fontNamesForFamilyName(fn) {
                    println("font: \(font)")
                }
            }
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    /// LocationService delegate method
    func updatedLocation(lat:String, lon:String) {
        println("Latitude = \(lon)")
        println("Longitude = \(lat)")
   
        weatherService.delegate = self;
        weatherService.getCurrentWeatherData(lat, lat: lon)
        
    }
    
    /// WeatherService delegate methods
    func currentWeatherData(weather:CurrentWeather) {
        weatherView.text = String(weather.temperature) + "°" + " " + weather.summary
        self.iconView.image = weather.icon!
    }
    
    func failedGettingCurrentData() {
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

