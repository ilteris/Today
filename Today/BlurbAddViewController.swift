//
//  BlurbAddViewController.swift
//  Today
//
//  Created by ilteris on 4/12/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import UIKit
import Realm
class BlurbAddViewController: UIViewController {

    let topView:UIImageView =   {
        let view = UIImageView(image: UIImage(named: "add_viewcontroller_top_bg"))
        view.backgroundColor = UIColor.clearColor()
        return view
        }()
    
    //weatherview
    //top header
    //middle textview
    //x and + buttons
    
    lazy var whatHappenedText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 28)
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
    
    
    
    lazy var addBlurbTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "AvenirNext-UltraLight", size: 35)
        textView.textColor = UIColor.blackColor()
        textView.textAlignment = .Center
        textView.text = "Read about Swift"
        textView.backgroundColor = UIColor.clearColor()

        
        
        return textView
        }()

    let okBtn:UIButton =   {
        let btn = UIButton()
        btn.setImage(UIImage(named: "okayBtn"), forState:.Normal)
        btn.backgroundColor = UIColor.clearColor()
        return btn

        
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
                
        superview.addSubview(topView)
        superview.addSubview(iconView)
        superview.addSubview(weatherView)
        superview.addSubview(whatHappenedText)
        superview.addSubview(addBlurbTextView)
        superview.addSubview(okBtn)
        
        okBtn.addTarget(self, action: "okBtnTapped:", forControlEvents:.TouchUpInside)

        
        
        
        topView.snp_makeConstraints { make in
            make.width.equalTo(superview.snp_width)
            make.top.equalTo(0)
            make.left.equalTo(0)
        }
        
        iconView.snp_makeConstraints { make in
            make.top.equalTo(self.topView.snp_top).offset(20)
            make.left.equalTo(10)
        }
        
        
        
        
        weatherView.snp_makeConstraints { make in
            make.left.equalTo(self.iconView.snp_right).offset(20)
            make.centerY.equalTo(self.iconView.snp_centerY)
            
        }

        
        
        whatHappenedText.snp_makeConstraints { make in
            make.width.equalTo(self.view.snp_width)
            make.centerX.equalTo(self.view.snp_centerX)
            make.top.equalTo(70)

        }
        
        addBlurbTextView.snp_makeConstraints { make in
            make.width.equalTo(self.view.snp_width).offset(-50)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view.snp_centerX)
            make.centerY.equalTo(self.view.snp_centerY).offset(-40)

        }
        
        
        
        okBtn.snp_makeConstraints { make in
            make.trailing.equalTo(self.view.snp_right).offset(-40)
            make.centerY.equalTo(self.view.snp_centerY).offset(40)
            
        }
        
        
        
        
        
    }
    
    func okBtnTapped(sender: UIButton!) {
        addBlurbTextView.resignFirstResponder()
        
        //get time
        //temp
        //summary
        //weathericon
        //save it.
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        
        println(documentsPath)
        
        
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        let timeFormatter = NSDateFormatter()

        dateFormatter.dateStyle = .ShortStyle
        timeFormatter.timeStyle = .ShortStyle
        timeFormatter.stringFromDate(date)
        dateFormatter.stringFromDate(date)
        println("date is \(dateFormatter.stringFromDate(date)) and time is \(timeFormatter.stringFromDate(date))")
        
        
        // Create a standalone object
        var newBlurb = Blurb()
        
        // Set & read properties
        newBlurb.summary = addBlurbTextView.text!
        newBlurb.temperature = BlurbsManager.sharedInstance.currentWeather.temperature
        newBlurb.weatherIcon = BlurbsManager.sharedInstance.currentWeather.iconString
        newBlurb.time = timeFormatter.stringFromDate(date)
        
        let realm = RLMRealm.defaultRealm() // Create realm pointing to default file
        
        //query the last date object from Realm DB. If dateFormatter.stringFromDate(date) == BlurbDate.date
        // then get the array and add the blurb to the array.
        // else
        // create a new Date object.
        // add the newBlurb as the array along with Date elements.
        
        let resultDate = BlurbDate.objectsInRealm(realm, withPredicate: NSPredicate(format: "date contains '\(dateFormatter.stringFromDate(date))'"))
        println("Number of results: \(resultDate.count)")
        
        if resultDate.count < 1 {
            
            var newData = BlurbDate()

            let dateName = NSDateFormatter()
            dateName.locale = NSLocale(localeIdentifier: "en_US")
            dateName.dateFormat = "EEEE"
            newData.name = dateName.stringFromDate(date)
            newData.date = dateFormatter.stringFromDate(date)
            newData.blurbs.addObject(newBlurb)
            realm.beginWriteTransaction()
            realm.addObject(newData)
            realm.commitWriteTransaction()

        }
        else
        {
            realm.beginWriteTransaction()
            var blurbDate:BlurbDate = resultDate[0] as! BlurbDate
            blurbDate.blurbs.addObject(newBlurb)
            realm.commitWriteTransaction()
            
            
        }
        
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
           
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var currentWeather = BlurbsManager.sharedInstance.currentWeather
        
        weatherView.text = String(currentWeather.temperature) + "°" + " " + currentWeather.summary
        self.iconView.image =  UIImage(named: currentWeather.iconString)
        
        addBlurbTextView.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
