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
   
    let transition = InteractiveAnimator()

    
    var notificationToken: RLMNotificationToken?

    
    let kCellId = "blurbCell"
    
    let tableView = UITableView(frame: CGRectZero, style: .Plain)

    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    
    let locationService = LocationService()
    let weatherService = WeatherService()
    


    lazy var whatHappenedText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 25)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.text = "WHAT HAPPENED TODAY?"
        label.numberOfLines = 2
        
        label.layer.shadowColor = UIColor.blackColor().CGColor
        label.layer.shadowOffset = CGSizeMake(1, 1)
        label.layer.shadowOpacity = 0.4;
        label.layer.shadowRadius = 2;
        label.sizeToFit()
        
        return label
        }()
    

    
    
    
    let bottomView:UIImageView =   {
        let view = UIImageView(image: UIImage(named: "bg"))
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
    
    


    
    lazy var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        return view
    
    }()
    
    
    
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

        
       
        superview.addSubview(lineView)

        superview.addSubview(scrollView)

        scrollView.addSubview(tableView)
        scrollView.addSubview(bottomView)
        bottomView.addSubview(weatherView)
        bottomView.addSubview(iconView)
        bottomView.addSubview(whatHappenedText)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 140
        
        scrollView.contentSize = CGSize(width:UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        scrollView.alwaysBounceVertical = true

        
        scrollView.snp_makeConstraints { make in
            make.width.equalTo(superview.snp_width)
            make.height.equalTo(superview.snp_height)
            make.top.equalTo(0)
            make.left.equalTo(0)
        }
        
        
        
        
        bottomView.snp_makeConstraints { make in
            make.width.equalTo(superview.snp_width)
            make.bottom.equalTo(superview.snp_bottom).offset(11)
            

        }
        
      
        tableView.snp_makeConstraints { make in
            make.width.equalTo(self.view.snp_width)
            //make.bottom.equalTo(superview.snp_centerY)
            //make.height.equalTo(425)
            make.bottom.equalTo(self.bottomView.snp_top).offset(11)
            make.top.equalTo(0)
            make.left.equalTo(0)
        }

        
      
        
        whatHappenedText.snp_makeConstraints { make in
            make.width.equalTo(self.view.snp_width)
            make.centerX.equalTo(self.bottomView.snp_centerX)
            make.top.equalTo(self.bottomView.snp_top).offset(40)
            
        }
        
        lineView.snp_makeConstraints { make in
            make.width.equalTo(0.5)
            make.height.equalTo(self.tableView.snp_height)
            make.top.equalTo(0)
            make.left.equalTo(85)
            
        }
        
        iconView.snp_makeConstraints { make in
            make.bottom.equalTo(self.bottomView.snp_bottom).offset(-20)
            make.left.equalTo(10)
        }

        weatherView.snp_makeConstraints { make in
            make.left.equalTo(self.iconView.snp_right).offset(20)
            make.centerY.equalTo(self.iconView.snp_centerY)
            
        }
        
       
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationService.delegate = self
        navigationController?.delegate = self
        println(RLMRealm.defaultRealm().path)
        
        tableView.registerClass(BlurbTableCell.classForCoder(), forCellReuseIdentifier: kCellId)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        
        
        // add the tap gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: Selector("didTap"))
        bottomView.addGestureRecognizer(tap)
        
        objects = BlurbDate.allObjects().toArray(BlurbDate.self)
        
        
        notificationToken = RLMRealm.defaultRealm().addNotificationBlock { note, realm in
            self.objects = BlurbDate.allObjects().toArray(BlurbDate.self)
            self.tableView.reloadData()
        }
        
        
        let pan = UIPanGestureRecognizer(target: self, action: Selector("didPan:"))
        scrollView.panGestureRecognizer.requireGestureRecognizerToFail(pan)
        scrollView.addGestureRecognizer(pan)
        
        
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
        return 60
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
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Left
        paragraphStyle.lineSpacing = 0

        cell.summaryLabel.attributedText =
            NSMutableAttributedString(
                string: (item["summary"] as? String)!,
                attributes:
                [
                    NSParagraphStyleAttributeName: paragraphStyle,
                    NSKernAttributeName: -0.4
                    
                ])
        cell.summaryLabel.sizeToFit()

        cell.timeLabel.text = item["time"] as? String
        var iconName:String  = (item["weatherIcon"] as? String)! + " 2"
        
        cell.iconView.image =  UIImage(named: iconName)
        cell.weatherLabel.text  = (item["temperature"] as? String)! + "° " + (item["weatherDescription"] as? String)!
        
        return cell
    }
    
    
    
    
    func didTap() {
        loadAddBlurbView()

    }
    
    func didPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .Began:
            transition.interactive = true
            let vc = BlurbAddViewController()
            navigationController?.pushViewController(vc, animated: true )
            
        default:
            transition.handlePan(recognizer)
            
        }
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
 
  
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
}


extension MainViewController: UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.operation = operation
        return transition
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if !transition.interactive {
            return nil
        }
        return transition
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





