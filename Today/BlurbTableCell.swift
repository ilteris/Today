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

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None

        timeLabel.backgroundColor = UIColor.clearColor()
        timeLabel.textColor = UIColor.blackColor()
        timeLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 13)
        timeLabel.textColor = UIColor(red: 0.631, green: 0.651, blue: 0.678, alpha: 1)
        timeLabel.textAlignment = .Right
        self.contentView.addSubview(timeLabel)
        
        summaryLabel.backgroundColor = UIColor.clearColor()
        summaryLabel.textColor = UIColor.blackColor()
        summaryLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 24)
        summaryLabel.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(summaryLabel)
        
        
       
        
        lineView.backgroundColor = UIColor.blackColor()
        self.contentView.addSubview(lineView)
        
        circleView.backgroundColor = UIColor.whiteColor()
        circleView.layer.borderWidth = 2
        circleView.layer.cornerRadius = 10
        circleView.layer.borderColor = UIColor(red: 0.592, green: 0.808, blue: 0.771, alpha: 1.000).CGColor

        self.contentView.addSubview(circleView)
        
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeLabel.snp_makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.width.equalTo(80)
            
        }
       
        
        circleView.snp_makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.left.equalTo(self.timeLabel.snp_right).offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            
        }
        
     
        
        summaryLabel.snp_makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.left.equalTo(self.circleView.snp_rightMargin).offset(30)
        }
        
        lineView.snp_makeConstraints { make in
            make.centerX.equalTo(self.circleView.snp_centerX)
            make.height.equalTo(80)
            make.top.equalTo(0)
            make.width.equalTo(0.5)
            
        }
        
        
        
    }
    
    func setBlurbSummary(blurb:Blurb) {
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Right
        
        
        timeLabel.attributedText =
            NSAttributedString(
                string: blurb.date,
                attributes:
                [
                    NSParagraphStyleAttributeName: paragraphStyle,
                    NSKernAttributeName: 0.4
                    
                ])
        

        self.summaryLabel.text = blurb.summary;
        
    }

    
    
}
