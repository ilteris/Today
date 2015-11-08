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


  let transition = InteractiveAnimator()



  let topView:UIImageView =   {
    let view = UIImageView(image: UIImage(named: "bg"))
    view.backgroundColor = UIColor.clearColor()
    return view
  }()

  //weatherview
  //top header
  //middle textview
  //x and + buttons

  lazy var whatHappenedText: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-UltraLight", size: 25)
    label.textColor = UIColor.whiteColor()
    label.textAlignment = .Center
    label.text = "WHAT HAPPENED TODAY?"
    label.numberOfLines = 2

    label.layer.shadowColor = UIColor.whiteColor().CGColor
    label.layer.shadowOffset = CGSizeMake(0, 1)
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



  lazy var addBlurbTextField: UITextField = {
    let textField = UITextField()
    textField.font = UIFont(name: "AvenirNext-Regular", size: 35)
    textField.textColor = UIColor.blackColor()
    textField.textAlignment = .Left
    textField.text = ""
    textField.backgroundColor = UIColor.clearColor()
    textField.returnKeyType = .Done
    textField.addTarget(self, action: "textFieldDidReturn:", forControlEvents: .EditingDidEndOnExit)
    textField.adjustsFontSizeToFitWidth = true
    return textField
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

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {

    view = UIView(frame: UIScreen.mainScreen().bounds)
    view.backgroundColor = UIColor.whiteColor()
    let superview = view


    topView.addSubview(iconView)
    topView.addSubview(weatherView)
    topView.addSubview(whatHappenedText)
    superview.addSubview(addBlurbTextField)
    superview.addSubview(okBtn)
    superview.addSubview(topView)


    okBtn.addTarget(self, action: "okBtnTapped:", forControlEvents:.TouchUpInside)

    topView.translatesAutoresizingMaskIntoConstraints = false
    iconView.translatesAutoresizingMaskIntoConstraints = false
    weatherView.translatesAutoresizingMaskIntoConstraints = false
    whatHappenedText.translatesAutoresizingMaskIntoConstraints = false
    addBlurbTextField.translatesAutoresizingMaskIntoConstraints = false
    okBtn.translatesAutoresizingMaskIntoConstraints = false

    let topView_width = topView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor)

    let topView_centerX = topView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor)
    let topView_top = topView.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: -11)
    let iconView_left = iconView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: 10)
    let iconView_bottom = iconView.bottomAnchor.constraintEqualToAnchor(topView.bottomAnchor, constant: -20)

    let weatherView_left = weatherView.leftAnchor.constraintEqualToAnchor(iconView.rightAnchor, constant: 20)
    let weatherView_centerY = weatherView.centerYAnchor.constraintEqualToAnchor(iconView.centerYAnchor)

    let  whatHappenedText_centerX =  whatHappenedText.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor)
    let  whatHappenedText_top =  whatHappenedText.topAnchor.constraintEqualToAnchor(self.topView.topAnchor, constant: 40)

    let  addBlurbTextField_centerX =  addBlurbTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor)
    let  addBlurbTextField_centerY =  addBlurbTextField.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor)

    let  addBlurbTextField_width =  addBlurbTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor)
    let  addBlurbTextField_height =  addBlurbTextField.heightAnchor.constraintEqualToAnchor(nil,constant:300)

    let  okBtn_trailing =  okBtn.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor, constant:-40)
    let  okBtn_centerY =  okBtn.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: 40)




    NSLayoutConstraint.activateConstraints([
      topView_width,
      topView_centerX,
      topView_top,
      iconView_left,
      iconView_bottom,
      weatherView_left,
      weatherView_centerY,
      whatHappenedText_centerX,
      whatHappenedText_top,
      addBlurbTextField_centerX,
      addBlurbTextField_centerY,
      addBlurbTextField_width,
      addBlurbTextField_height,
      okBtn_trailing,
      okBtn_centerY



      ])
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let currentWeather = BlurbsManager.sharedInstance.currentWeather


    weatherView.text = String(currentWeather.temperature) + "°" + " " + currentWeather.summary
    self.iconView.image =  UIImage(named: currentWeather.iconString)

            let pan = UIPanGestureRecognizer(target: self, action: Selector("didPan:"))
            view.addGestureRecognizer(pan)

  }

  func textFieldDidReturn(textField: UITextField!) {
    textField.sizeToFit()
    textField.resignFirstResponder()
    ///activate pan after keyboard is gone
  }

  func writeBlurp()  {
    //get time
    //temp
    //summary
    //weathericon
    //save it.

    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString

    print(documentsPath)


    let date = NSDate()
    let dateFormatter = NSDateFormatter()
    let timeFormatter = NSDateFormatter()

    dateFormatter.dateStyle = .ShortStyle
    timeFormatter.timeStyle = .ShortStyle
    timeFormatter.stringFromDate(date)
    dateFormatter.stringFromDate(date)
    print("date is \(dateFormatter.stringFromDate(date)) and time is \(timeFormatter.stringFromDate(date))")


    // Create a standalone object
    let newBlurb = Blurb()

    // Set & read properties
    newBlurb.summary = addBlurbTextField.text!
    newBlurb.temperature = BlurbsManager.sharedInstance.currentWeather.temperature
    newBlurb.weatherIcon = BlurbsManager.sharedInstance.currentWeather.iconString
    newBlurb.weatherDescription = BlurbsManager.sharedInstance.currentWeather.summary
    newBlurb.time = timeFormatter.stringFromDate(date)

    let realm = RLMRealm.defaultRealm() // Create realm pointing to default file

    //query the last date object from Realm DB. If dateFormatter.stringFromDate(date) == BlurbDate.date
    // then get the array and add the blurb to the array.
    // else
    // create a new Date object.
    // add the newBlurb as the array along with Date elements.

    let resultDate = BlurbDate.objectsInRealm(realm, withPredicate: NSPredicate(format: "date contains '\(dateFormatter.stringFromDate(date))'"))
    print("Number of results: \(resultDate.count)")

 if resultDate.count < 1 {

      let newData = BlurbDate()

      let dateName = NSDateFormatter()
      dateName.locale = NSLocale(localeIdentifier: "en_US")
      dateName.dateFormat = "EEEE"
      newData.name = dateName.stringFromDate(date)
      newData.date = dateFormatter.stringFromDate(date)
      newData.blurbs.addObject(newBlurb)
      realm.beginWriteTransaction()
      realm.addObject(newData)
      try! realm.commitWriteTransaction()

 } else {

      realm.beginWriteTransaction()
      let blurbDate:BlurbDate = resultDate[0] as! BlurbDate
      blurbDate.blurbs.addObject(newBlurb)
      try! realm.commitWriteTransaction()


    }


  }


  func okBtnTapped(sender: UIButton!) {

    if addBlurbTextField.text != "" {

       writeBlurp()


    }
    transition.interactive = true
    addBlurbTextField.resignFirstResponder()
    if let navController = self.navigationController {
      navController.popViewControllerAnimated(true)

    }


  }



  func didPan(recognizer: UIPanGestureRecognizer) {
    switch recognizer.state {
    case .Began:
//      if addBlurbTextField.text != "" {
//        try writeBlurp()
//      }
      transition.interactive = true
      addBlurbTextField.resignFirstResponder()
      if let navController = self.navigationController {
        navController.popViewControllerAnimated(true)
      }

    default:
      print("default")

      transition.handleBlurbPan(recognizer)
    }
  }



  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.Default
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
