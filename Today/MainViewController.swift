//
//  ViewController.swift
//  Today
//
//  Created by ilteris on 4/10/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import UIKit
import Snap
import Realm


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CurrentLocation, ForecastIO {

    
    var objects = [BlurbDate]()

    var notificationToken: RLMNotificationToken?

    
    let kCellId = "blurbCell"
    
    let tableView = UITableView(frame: CGRectZero, style: .Plain)

    let bottomView:UIImageView =   {
        let view = UIImageView(image: UIImage(named: "bottom_bg"))
        view.backgroundColor = UIColor.clearColor()
        view.userInteractionEnabled = true
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
        tableView.delegate = self
        
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
    
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let day = objects[section]
        return day["name"] as? String
    }
    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let day = objects[section]
        let view = SectionHeaderView()
        view.titleLabel.text = (day["name"] as! String).uppercaseString
        return view
    }

     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return objects.count
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day = objects[section]
        let items = day["blurbs"] as! RLMArray
        return Int(items.count)
    }
    

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("blurbCell", forIndexPath: indexPath)as! BlurbTableCell
        let day = objects[indexPath.section]
        let items = day["blurbs"] as! RLMArray
        let int = UInt(indexPath.row)
        let item = items[int] as! Blurb
        
        cell.summaryLabel.text = item["summary"] as? String
        cell.timeLabel.text = item["time"] as? String
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationService.delegate = self

        
        tableView.registerClass(BlurbTableCell.classForCoder(), forCellReuseIdentifier: kCellId)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        

        // add the tap gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: Selector("didTap"))
        bottomView.addGestureRecognizer(tap)

        
        
        notificationToken = RLMRealm.defaultRealm().addNotificationBlock { note, realm in
            self.tableView.reloadData()
        }
        
        objects = BlurbDate.allObjects().toArray(BlurbDate.self)
        // let sortedObjects = unsortedObjects.sortedResultsUsingProperty("date", ascending: true)
        // objects.append(sortedObjects)
        
        println(objects)

        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didTap() {
        loadAddBlurbView()

    }
    
    
    /// LocationService delegate method
    func updatedLocation(lat:String, lon:String) {
        println("Latitude = \(lon)")
        println("Longitude = \(lat)")
   
        weatherService.delegate = self;
        weatherService.getCurrentWeatherData(lat, lat: lon)
        
    }
    
    /// WeatherService delegate methods
    func currentWeatherData(currentWeather:CurrentWeather) {
        weatherView.text = String(currentWeather.temperature) + "°" + " " + currentWeather.summary
        self.iconView.image =  UIImage(named: currentWeather.iconString)
        BlurbsManager.sharedInstance.currentWeather = (temperature:String(currentWeather.temperature), summary:currentWeather.summary, iconString:currentWeather.iconString)
    }
    
    func failedGettingCurrentData() {
        
    }
    
    
    func loadAddBlurbView() {
        let vc = BlurbAddViewController()
        navigationController?.pushViewController(vc, animated: true )

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
}


extension RLMResults {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for result in self {
            if let result = result as? T {
                array.append(result)
            }
        }
        return array
    }
}





