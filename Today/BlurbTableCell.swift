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
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        summaryLabel.backgroundColor = UIColor.clearColor()
        summaryLabel.textColor = UIColor.blackColor()
        summaryLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        summaryLabel.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(summaryLabel)
        
        timeLabel.backgroundColor = UIColor.clearColor()
        timeLabel.textColor = UIColor.blackColor()
        timeLabel.font = UIFont.systemFontOfSize(20)
        timeLabel.textAlignment = NSTextAlignment.Left
        
        self.contentView.addSubview(timeLabel)
        
      
        
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        summaryLabel.snp_makeConstraints { make in
            make.top.equalTo(10).offset(10)
            make.left.equalTo(20)
            make.width.equalTo(200)
        }
        
        timeLabel.snp_makeConstraints { make in
            make.top.equalTo(self.summaryLabel.snp_bottom).offset(5)
            make.left.equalTo(20)
            make.width.equalTo(self.contentView.snp_width)
        }
        
        
        
    }
    
}
