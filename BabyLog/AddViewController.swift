//
//  AddViewController.swift
//  BabyLog
//
//  Created by mj.zhou on 15/1/29.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,AddViewControllerDelegate{
    
    let items = ["奶粉","开水","便便"]
    
    @IBOutlet weak var itemPicker: UIPickerView!
    @IBOutlet weak var txtCount: UITextField!
    @IBOutlet weak var btnSelectDate: UIButton!
    @IBOutlet weak var txtRemark: UITextField!
    
    var selectDate:NSDate=NSDate()
    var dateFormatter = NSDateFormatter()
    
    var delegate:FirstViewControllerDelegate!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        itemPicker.dataSource = self
        itemPicker.delegate=self
        
        var rightBtn = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: "done")
        self.navigationItem.rightBarButtonItem=rightBtn
        
        dateFormatter.dateFormat="yyyy-MM-dd HH:mm"
        let now = dateFormatter.stringFromDate(NSDate())
        
        btnSelectDate.setTitle(now, forState: UIControlState.Normal)
    }
    
    @IBAction func onFinishEdit(sender: AnyObject) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onCloseKeyboard(sender: AnyObject) {
        self.txtCount.resignFirstResponder()
        self.txtRemark.resignFirstResponder()
    }
    
    
    @IBAction func onSelectDate(sender: AnyObject) {
        
        let anyobj:AnyObject? = self.storyboard?.instantiateViewControllerWithIdentifier("sb_selectDateController")

        if  let vc = anyobj as? SelectDateController{
            vc.delegate=self
            self.navigationController?.pushViewController(vc, animated: true)
        }

       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int {
        return items.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return items[row]
    }
    
    func pickerView(pickerView: UIPickerView,didSelectRow row: Int,inComponent component: Int){
        if row == 2{
            self.txtCount.hidden=true
        }
        else{
            self.txtCount.hidden=false
        }
        
        self.onCloseKeyboard(self)
    }
    
    func done(){
        
        let count:Int? = txtCount.text.toInt()
        let remark = txtRemark.text
        let type = itemPicker.selectedRowInComponent(0)
        if !txtCount.hidden{
            if txtCount.text.isEmpty
            {
                txtCount.becomeFirstResponder()
                
                return
            }
        }
        
        var log = FeedLog()
        if count==nil{
        
        }
        else{
         log.count = count!
        }
       
        log.logTime = selectDate
        let logDay = dateFormatter.stringFromDate(selectDate)
        log.logDay = logDay
        log.id=NSUUID().UUIDString
        log.remark=remark
        log.type=type
        
        Db.insert(log)
        
        delegate.setLogDetail()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setDate(date: NSDate) {
        selectDate=date
        dateFormatter.dateFormat="yyyy-MM-dd HH:mm"
        let now = dateFormatter.stringFromDate(date)
        btnSelectDate.setTitle(now, forState: UIControlState.Normal)
    }
    
    func getDate()->NSDate{
        return selectDate
    }
}
