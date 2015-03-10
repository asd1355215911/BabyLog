//
//  DayHistoryViewController.swift
//  BabyLog
//
//  Created by mj.zhou on 15/3/6.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import UIKit

class DayHistoryViewController: UITableViewController {

    var list = [FeedLog]()
    var selectedDay = ""
    let dataFormatter = NSDateFormatter()
    
   // @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataFormatter.dateFormat="yyyy-MM-dd HH:mm"
        list = FeedLogService.getHistoryByDay(selectedDay)
        
        self.navigationItem.title=selectedDay
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell =  tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? HistoryDayCell
        
        let index = indexPath.row
        
        var hisItem = list[index]
        var typeName = TypeTool.typeToTitle(hisItem.type)
        
        var unit = ""
        if hisItem.type != 2{
            unit = "ml"
            cell!.detailText.text = "\(typeName) \(hisItem.count) \(unit)"
        }
        else{
            cell!.detailText.text = typeName
        }
        cell!.remarkText.text = hisItem.remark.isEmpty ? "备注":hisItem.remark
        cell!.timeText.text = dataFormatter.stringFromDate(hisItem.logTime)
        
        //cell!.autoLayout()
        
        return cell!
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let id = list[indexPath.row].id
        FeedLogService.remove(id)
        list.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle
    {
        return UITableViewCellEditingStyle.Delete
    }

}
