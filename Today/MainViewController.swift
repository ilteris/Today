//
//  ViewController.swift
//  Today
//
//  Created by ilteris on 4/10/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

import UIKit
import Snap

class MainViewController: UIViewController, UITableViewDataSource {

    let kCellId = "blurbCell"
    
    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    
    
    
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
        
        superview.addSubview(tableView)
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.snp_makeConstraints { make in
            make.width.equalTo(superview.snp_width)
            make.bottom.equalTo(superview.snp_bottom)
            make.top.equalTo(0)
            make.left.equalTo(0)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BlurbsManager.sharedInstance.blurbs.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let blurb = BlurbsManager.sharedInstance.blurbs[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("blurbCell") as! BlurbTableCell
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(BlurbTableCell.classForCoder(), forCellReuseIdentifier: kCellId)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

