//
//  FirstViewController.swift
//  BabyLog
//
//  Created by mj.zhou on 15/1/19.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,FirstViewControllerDelegate {
    @IBOutlet weak var lblLastDrinkingTime: UILabel!
    @IBOutlet weak var lblLastDrinkMilkTime: UILabel!
    @IBOutlet weak var lblLastShitTime: UILabel!
    @IBOutlet weak var lblShit: UILabel!
    @IBOutlet weak var lblMilk: UILabel!

    @IBOutlet weak var lblWater: UILabel!
    @IBOutlet weak var lblNow: UILabel!
   
    
    let dateFormatter=NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat="yyyy-MM-dd"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        setLogDetail()
        println("1st view will apper")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func onShowAddView(sender: UIBarButtonItem) {
        let anyObj:AnyObject? = self.storyboard?.instantiateViewControllerWithIdentifier("sb_addViewController")
        if let vc = anyObj as? AddViewController{
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    func setLogDetail(){
        let detail = FeedLogService.getDetail()
        lblLastDrinkMilkTime.text=detail.lastDrinkMilkDesc.isEmpty ? "" : "最近喂奶\(detail.lastDrinkMilkDesc)"
        lblLastDrinkingTime.text=detail.lastDrinkWaterDesc.isEmpty ? "" : "最近喝水\(detail.lastDrinkWaterDesc)"
        lblLastShitTime.text=detail.lastShitDesc.isEmpty ? "" : "最近便便\(detail.lastShitDesc)"
        
        lblShit.text="今日便便\(detail.shitCount)次"
        lblMilk.text="今日喂奶\(detail.milkCount)ml"
        lblWater.text="今日喂水\(detail.waterCount)ml"
        
        lblNow.text=dateFormatter.stringFromDate(NSDate())
    }

}

