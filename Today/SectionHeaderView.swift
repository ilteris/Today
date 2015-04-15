//
//  SectionHeaderView.swift
//  Today
//
//  Created by ilteris on 4/13/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {
    
    // MARK: - Properties
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.blackColor()
        return label
        }()
    
    // MARK: - Initialiers
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //		backgroundColor = UIColor(white: 1, alpha: 0.95)
        addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { make in
            make.centerY.equalTo(self.snp_centerY)
            make.left.equalTo(self.snp_left).offset(10)
            make.top.equalTo(self.snp_top).offset(20)

        }
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
