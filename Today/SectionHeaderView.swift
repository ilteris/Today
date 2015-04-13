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
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont(name: "Avenir", size: 18)
        label.textColor = UIColor(red: 0.514, green: 0.525, blue: 0.541, alpha: 1)
        return label
        }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor = UIColor(red: 0.906, green: 0.914, blue: 0.918, alpha: 1)
        return view
        }()
    
    
    // MARK: - Initialiers
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //		backgroundColor = UIColor(white: 1, alpha: 0.95)
        addSubview(titleLabel)
        addSubview(lineView)
        
        let views = [
            "titleLabel": titleLabel,
            "lineView": lineView
        ]
        
        let metrics = [
            "verticalMargin": 8
        ]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[titleLabel]|", options: nil, metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(verticalMargin)-[titleLabel]-(verticalMargin)-[lineView(1)]|", options: nil, metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[lineView]|", options: nil, metrics: metrics, views: views))
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
