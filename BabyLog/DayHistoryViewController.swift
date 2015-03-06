//
//  DayHistoryViewController.swift
//  BabyLog
//
//  Created by mj.zhou on 15/3/6.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import UIKit

class DayHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var list = [HistroyDayItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var item = HistroyDayItem()
        item.subTitle="喂奶"
        item.title="2015-01-01 17:00"
        list.append(item)
        
        
        self.navigationItem.title="2015-01-01"
        
        let size = self.view.bounds.size;
        let tableView = UITableView(frame: CGRectMake(0,0, size.width,size.height))
        tableView.delegate=self
        tableView.dataSource=self
        
        self.view.addSubview(tableView)
        
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
        
        return cell
        
    }
    
        func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
        {
            list.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        }
    
        func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle
        {
            return UITableViewCellEditingStyle.Delete
        }

}
