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

      titleLabel.translatesAutoresizingMaskIntoConstraints = false

      let titleLabel_centerY =  titleLabel.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor)
      let  titleLabel_left =  titleLabel.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 10)
      let  titleLabel_top =  titleLabel.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 20)

      NSLayoutConstraint.activateConstraints([
        titleLabel_centerY,
        titleLabel_left,
        titleLabel_top,
               ])

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
