//
//  SelectDateController.swift
//  BabyLog
//
//  Created by mj.zhou on 15/3/3.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import UIKit

class SelectDateController: UIViewController {
    
    var delegate:AddViewControllerDelegate!
   
    @IBOutlet weak var datePick: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var btnDateDone = UIBarButtonItem(title: "完成", style:.Plain, target: self, action: "selectDateDone")
        self.navigationItem.rightBarButtonItem=btnDateDone
        
        self.view.backgroundColor=UIColor.whiteColor()
        datePick.setDate(delegate.getDate(), animated: false)
        datePick.maximumDate=NSDate()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectDateDone(){
        let now = NSDate()
        
        if now.compare(datePick.date)==NSComparisonResult.OrderedAscending{
            let alert=UIAlertView()
            alert.title="不能选择比现在晚的时间"
            alert.addButtonWithTitle("知道了")
            alert.show()
            return
        }
        
        delegate.setDate(datePick.date)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
