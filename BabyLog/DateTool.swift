//
//  date.swift
//  BabyLog
//
//  Created by mj.zhou on 15/3/5.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import Foundation

class DateTool{
    class func friendlyDiffFromNow(date:NSDate)->String
    {
        
        let now = NSDate()
        
        let mostUnits: NSCalendarUnit = .YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit
        let components = NSCalendar.currentCalendar().components(mostUnits,fromDate:date, toDate:now, options:nil)
        
        if components.day>=1{
            return String(components.day)+"天之前"
        }
        
        if (components.hour>=1&&components.hour<24){
            return String(components.hour)+"小时之前"
        }
        
        if components.minute>=10&&components.minute<60{
            return String(components.minute)+"分钟之前"
        }
        else{
            return "刚刚"
        }

    }
    
    class func diff(from:NSDate,to:NSDate)->NSDateComponents{
        
        let mostUnits: NSCalendarUnit = .YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit
        let components = NSCalendar.currentCalendar().components(mostUnits,fromDate:from, toDate:to, options:nil)
        
        return components;
    }
}