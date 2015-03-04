//
//  Db.swift
//  BabyLog
//
//  Created by mj.zhou on 15/3/4.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import Foundation

var logs = [FeedLog]()

class Db{
    
    class func insert(log:FeedLog){
        logs.append(log)
    }
    
   class func remove(id:String){
        var index = 0
        for log in logs
        {
            if id == log.id{
                break
            }
            index++
        }
        
        logs.removeAtIndex(index)
    }
    
   class func update(log:FeedLog){
        
        for l in logs
        {
            if log.id == l.id{
                l.count=log.count
                l.date=log.date
                l.type=log.type
                l.remark=log.remark
                break
            }
        }
        
    }
    
    class func getDetail()->LogDetail {
        
        var milkCount = 0
        var waterCount = 0
        var shitCount = 0
        
        var lastMilkTime:NSDate?
        var lastWaterTime:NSDate?
        var lastShitTime:NSDate?
        
        
        for log in logs{
            let now = NSDate()
            var isToday = false
            var diff = DateTool.diff(log.date,to:now)
            if diff.day==0{
                isToday=true
            }
            else{
                isToday=false
            }
            
            if log.type==0{
                if isToday{
                    milkCount+=log.count
                }
                if lastMilkTime==nil{
                     lastMilkTime=log.date
                }
                else{
                   
                    if log.date.compare(lastMilkTime!)==NSComparisonResult.OrderedDescending{
                        lastMilkTime=log.date
                    }
                }
            }
            else if log.type==1{
                if isToday{
                    waterCount+=log.count
                }
                if lastWaterTime==nil{
                    lastWaterTime=log.date
                }
                else{
                    if log.date.compare(lastWaterTime!)==NSComparisonResult.OrderedDescending {
                        lastWaterTime=log.date
                    }
                }
            }
            else if log.type==2{
                if isToday{
                    shitCount++
                }
                if lastShitTime==nil{
                    lastShitTime=log.date
                }
                else{
                    if log.date.compare(lastShitTime!)==NSComparisonResult.OrderedDescending {
                        lastShitTime=log.date
                    }
                }
            }
        }
        
        var detail = LogDetail()
        detail.milkCount=milkCount
        detail.waterCount=waterCount
        detail.shitCount=shitCount
        
        if lastMilkTime==nil{
            detail.lastDrinkMilkDesc=""
        }
        else{
             detail.lastDrinkMilkDesc=DateTool.friendlyDiffFromNow(lastMilkTime!)
        }
        if lastWaterTime==nil{
            detail.lastDrinkWaterDesc=""
        }
        else{
            detail.lastDrinkWaterDesc=DateTool.friendlyDiffFromNow(lastWaterTime!)
        }
        if lastShitTime==nil{
            detail.lastShitDesc=""
        }
        else{
            detail.lastShitDesc=DateTool.friendlyDiffFromNow(lastShitTime!)
        }

        
        return detail
    }
    
}