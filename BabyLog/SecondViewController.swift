//
//  SecondViewController.swift
//  BabyLog
//
//  Created by mj.zhou on 15/1/19.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tb:UITableView = UITableView()
    
    var list = [HistroyDayItem]()

    @IBOutlet var tbView: UIControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib。
        
        tb.delegate=self
        tb.dataSource=self
        let h = tbView.bounds.size.height
        let w = tbView.bounds.size.width
        tb.frame=CGRectMake(0,0,w,h)
        tbView.addSubview(tb)
        
        var item = HistroyDayItem()
        item.id="1"
        item.title="2015-01-01"
        item.subTitle="milk100ml water200ml shit4ci"
        
        var item1 = HistroyDayItem()
        item1.id="2"
        item1.title="2015-01-02"
        item1.subTitle="milk100ml water200ml shit4ci"

        
        list.append(item)
        list.append(item1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier : "cell")
        
        let index = indexPath.row
        
        var hisItem = list[index]

        cell.textLabel?.text = hisItem.subTitle
        cell.detailTextLabel?.text = hisItem.title
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let index = indexPath.row
        let anyObj:AnyObject? = self.storyboard?.instantiateViewControllerWithIdentifier("sb_historyDayViewController")
        if let vc = anyObj as? DayHistoryViewController{
           
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

