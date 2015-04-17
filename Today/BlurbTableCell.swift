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
    
    
    
    
    required init(coder aDecoder: NSCoder) {
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
     //   self.contentView.addSubview(iconView)
     //   iconView.alpha = 0.5

        self.contentView.addSubview(weatherLabel)
    
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeLabel.snp_makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.width.equalTo(55)
            make.leading.equalTo(10)
            
        }
       
        
        circleView.snp_makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.left.equalTo(self.timeLabel.snp_right).offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            
        }
        
     
        
        summaryLabel.snp_makeConstraints { make in
            make.top.equalTo(self.timeLabel.snp_top).offset(-10)
            make.leading.equalTo(self.circleView.snp_right).offset(10)
            make.trailing.equalTo(self.contentView.snp_right).offset(-10)
        }
        
        
        lineView.snp_makeConstraints { make in
            make.centerX.equalTo(self.circleView.snp_centerX)
            make.height.equalTo(140)
            make.top.equalTo(0)
            make.width.equalTo(0.5)
            
        }
        
//        iconView.snp_makeConstraints { make in
//            make.centerX.equalTo(self.timeLabel.snp_centerX)
//            make.top.equalTo(self.timeLabel.snp_bottom).offset(10)
//            
//        }
        
        weatherLabel.snp_makeConstraints { make in
            make.centerX.equalTo(self.timeLabel.snp_centerX)
            make.top.equalTo(self.timeLabel.snp_bottom).offset(10)
            make.leading.equalTo(10)
           // make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
        }
        
        
        
    }
    
    func setBlurbSummary(blurb:Blurb) {
        
        var paragraphStyle = NSMutableParagraphStyle()
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


