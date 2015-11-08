//
//  BlurbTableCell.swift
//  Today
//
//  Created by ilteris on 4/10/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import UIKit

class BlurbTableCell: UITableViewCell {

  var summaryLabel = UILabel()
  var timeLabel = UILabel()
  var circleView = UIView()
  var lineView = UIView()


  let iconView:UIImageView =   {
    let view = UIImageView()
    view.backgroundColor = UIColor.clearColor()
    return view
  }()


  lazy var weatherLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-Regular", size: 10)
    label.textColor = UIColor(red: 0.131, green: 0.151, blue: 0.178, alpha: 1)
    label.textAlignment = .Center
    label.numberOfLines = 2
    return label
  }()




  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

    super.init(style: style, reuseIdentifier: reuseIdentifier)

    selectionStyle = .None

    timeLabel.backgroundColor = UIColor.clearColor()
    timeLabel.textColor = UIColor.blackColor()
    timeLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
    timeLabel.textColor = UIColor(red: 0.131, green: 0.151, blue: 0.178, alpha: 1)
    timeLabel.textAlignment = .Center
    self.contentView.addSubview(timeLabel)

    summaryLabel.backgroundColor = UIColor.clearColor()
    summaryLabel.textColor = UIColor.blackColor()
    summaryLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 23)
    summaryLabel.textAlignment = NSTextAlignment.Left
    summaryLabel.layer.shadowColor = UIColor.whiteColor().CGColor
    summaryLabel.layer.shadowOffset = CGSizeMake(0, 1)
    summaryLabel.layer.shadowOpacity = 1
    summaryLabel.numberOfLines = 5


    self.contentView.addSubview(summaryLabel)

    lineView.backgroundColor = UIColor.blackColor()
    self.contentView.addSubview(lineView)

    circleView.backgroundColor = UIColor.whiteColor()
    circleView.layer.borderWidth = 3
    circleView.layer.cornerRadius = 10
    circleView.layer.borderColor = UIColor(red: 0.531, green: 0.551, blue: 0.578, alpha: 1).CGColor

    self.contentView.addSubview(circleView)


    self.contentView.addSubview(weatherLabel)

    summaryLabel.translatesAutoresizingMaskIntoConstraints = false
    weatherLabel.translatesAutoresizingMaskIntoConstraints = false
    circleView.translatesAutoresizingMaskIntoConstraints = false
    lineView.translatesAutoresizingMaskIntoConstraints = false
    timeLabel.translatesAutoresizingMaskIntoConstraints = false

    let timeLabel_width = timeLabel.widthAnchor.constraintEqualToAnchor(nil, constant:55)
    let timeLabel_centerY = timeLabel.centerYAnchor.constraintEqualToAnchor(contentView.centerYAnchor)
    let timeLabel_leading = timeLabel.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor, constant:10)

    let circleView_left = circleView.leftAnchor.constraintEqualToAnchor(timeLabel.rightAnchor, constant: 10)

    let circleView_centerY = circleView.centerYAnchor.constraintEqualToAnchor(contentView.centerYAnchor)
     let circleView_width = circleView.widthAnchor.constraintEqualToAnchor(nil, constant:20)
    let circleView_height = circleView.heightAnchor.constraintEqualToAnchor(nil, constant:20)


    let summaryLabel_top = summaryLabel.topAnchor.constraintEqualToAnchor(timeLabel.topAnchor, constant: -10)

    let  summaryLabel_leading =  summaryLabel.leadingAnchor.constraintEqualToAnchor(circleView.trailingAnchor, constant:10)


    let  lineView_centerX =  lineView.centerXAnchor.constraintEqualToAnchor(circleView.centerXAnchor)
    let  lineView_height =  lineView.heightAnchor.constraintEqualToAnchor(nil, constant:140)

    let  lineView_width =  lineView.widthAnchor.constraintEqualToAnchor(nil, constant:0.5)


    let  lineView_top =  lineView.topAnchor.constraintEqualToAnchor(contentView.topAnchor)

    let  weatherLabel_centerX =  weatherLabel.centerXAnchor.constraintEqualToAnchor(timeLabel.centerXAnchor)
    let  weatherLabel_top =  weatherLabel.topAnchor.constraintEqualToAnchor(timeLabel.bottomAnchor, constant: 10)
    let  weatherLabel_leading =  weatherLabel.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor, constant: 10)


    NSLayoutConstraint.activateConstraints([
      timeLabel_width,
    timeLabel_centerY,
      timeLabel_leading,
      circleView_left,
      circleView_centerY,
      circleView_width,
      circleView_height,
      summaryLabel_top,
      summaryLabel_leading,
      lineView_centerX,
      lineView_height,
      lineView_width,
      lineView_top,
      weatherLabel_centerX,
      lineView_height,
      lineView_top,
      weatherLabel_top,
      weatherLabel_leading,
      ])


  }



  override func layoutSubviews() {
    super.layoutSubviews()




  }

  func setBlurbSummary(blurb:Blurb) {

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.Right


    timeLabel.attributedText =
      NSAttributedString(
        string: blurb.time,
        attributes:
        [
          NSParagraphStyleAttributeName: paragraphStyle,
          NSKernAttributeName: 0.4

        ])


    self.summaryLabel.attributedText =
      NSAttributedString(
        string: blurb.summary,
        attributes:
        [
          NSParagraphStyleAttributeName: paragraphStyle,
          NSKernAttributeName: -0.4
          
        ])
    
    
    
  }
  
  
  
}


