//
//  FeedLogService.swift
//  BabyLog
//
//  Created by mj.zhou on 15/3/7.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import Foundation

class FeedLogService {
    
    class func insert(log:FeedLog){
        
        let sql="INSERT INTO FEEDLOGS (ID,COUNT,TYPE,LOGTIME,LOGDAY,REMARK) "+"VALUES (?,?,?,?,?,?)"
        let db = Db.getDb()
        db.open()
        db.executeUpdate(sql, withArgumentsInArray: [log.id,log.count,log.type,log.logTime,log.logDay,log.remark])
        db.close()
    }
    
    class func remove(id:String){
        let sql = "DELETE FROM FEEDLOGS WHERE ID = ?"
        let db = Db.getDb()
        db.open()
        db.executeUpdate(sql, withArgumentsInArray: [id])
        db.close()
    }
    
    class func update(log:FeedLog){
        
        let sql = "UPDATE FEEDLOGS SET COUNT=?,TYPE=?,LOGTIME=?,LOGDAY=?,REMARK=? WHERE ID=?"
        let db = Db.getDb()
        db.open()
        db.executeUpdate(sql, withArgumentsInArray: [log.count,log.type,log.logTime,log.logDay,log.remark,log.id])
        db.close()
    }
    
    class func select(id:String)->FeedLog?{
        
        let sql = "SELECT * FROM FEEDLOGS WHERE ID = ?"
        let db = Db.getDb()
        db.open()
        let rs = db.executeQuery(sql, withArgumentsInArray: [id])
        var log:FeedLog?=FeedLog()
        while rs.next() {
            log?.id=rs.stringForColumn("ID")
            log?.count=Int(rs.intForColumn("COUNT"))
            log?.type=Int(rs.intForColumn("TYPE"))
            log?.remark=rs.stringForColumn("REMARK")
            log?.logTime=rs.dateForColumn("LOGTIME")
            log?.logDay=rs.stringForColumn("LOGDAY")
        }
        db.close()
        
        return log
    }
    
    class func todayLogs()->[FeedLog] {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat="yyyy-MM-dd"
        var nowDay = dateFormatter.stringFromDate(NSDate())
        
        let sql = "SELECT * FROM FEEDLOGS WHERE LOGDAY = ?"
        let db = Db.getDb()
        db.open()
        var rs = db.executeQuery(sql, withArgumentsInArray: [nowDay])
        
        var list = [FeedLog]()
        while rs.next(){
            var log:FeedLog=FeedLog()
            log.id=rs.stringForColumn("ID")
            log.count=Int(rs.intForColumn("COUNT"))
            log.type=Int(rs.intForColumn("TYPE"))
            log.remark=rs.stringForColumn("REMARK")
            log.logTime=rs.dateForColumn("LOGTIME")
            log.logDay=rs.stringForColumn("LOGDAY")
            list.append(log)
        }
        
        db.close()
        
        return list
    }
    
    class func getLastTime(type:Int)->NSDate?{
        
        let sql = "SELECT LOGTIME FROM FEEDLOGS WHERE TYPE = ? ORDER BY LOGTIME DESC lIMIT 1"
        let db = Db.getDb()
        db.open()
        var date:NSDate?
        
        var rs = db.executeQuery(sql, withArgumentsInArray: [type])
        while rs.next(){
            date = rs.dateForColumn("LOGTIME")
        }
        db.close()
        return date
    }
    
    
    class func getDetail()->LogDetail {
        
        var milkCount = 0
        var waterCount = 0
        var shitCount = 0
        
        let tls = todayLogs()
        for tl in tls{
            if tl.type==0{
                milkCount+=tl.count
            }
            else if tl.type==1{
                waterCount+=tl.count
            }
            else if tl.type==2{
                shitCount++
            }
        }
        
        var lastMilkTime:NSDate?
        var lastWaterTime:NSDate?
        var lastShitTime:NSDate?
        
        lastMilkTime=getLastTime(0)
        lastWaterTime=getLastTime(1)
        lastShitTime=getLastTime(2)
        
        
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
    
    class  func historyDayList()->[HistroyDayItem] {
        
        let sql = "SELECT SUM(COUNT) AS COUNT,TYPE,LOGDAY FROM FEEDLOGS GROUP BY LOGDAY,TYPE ORDER BY LOGDAY DESC "
        let db = Db.getDb()
        db.open()
        var rs = db.executeQuery(sql, withArgumentsInArray: nil)
        
        var logDay = ""
        var list = [HistroyDayItem]()
        var item:HistroyDayItem?
        
        while rs.next()
        {
            var d = rs.stringForColumn("LOGDAY")
            var c = rs.intForColumn("COUNT")
            var t = rs.intForColumn("TYPE")
            if d != logDay{
                logDay = d
                item=HistroyDayItem()
                list.append(item!)
            }
            if item != nil {
                item?.day=d
                if t == 0{
                    item?.milkCount+=Int(c)
                }
                else if t == 1{
                    item?.waterCount+=Int(c)
                }
                else if t == 2{
                    item?.shitCount+=Int(c)
                }
            }
        }
        db.close()
        return list
    }
    
    class func getHistoryByDay(day:String)->[FeedLog] {
    
        let sql = "SELECT * FROM FEEDLOGS WHERE LOGDAY = ? ORDER BY LOGTIME DESC"
        let db = Db.getDb()
        db.open()
        var rs = db.executeQuery(sql, withArgumentsInArray: [day])
        
        var list = [FeedLog]()
        while rs.next(){
            var log:FeedLog=FeedLog()
            log.id=rs.stringForColumn("ID")
            log.count=Int(rs.intForColumn("COUNT"))
            log.type=Int(rs.intForColumn("TYPE"))
            log.remark=rs.stringForColumn("REMARK")
            log.logTime=rs.dateForColumn("LOGTIME")
            log.logDay=rs.stringForColumn("LOGDAY")
            list.append(log)
        }
        
        db.close()
        
        return list
        
    }
    
    class func get7DayLineData()->(mList:[LineData],wList:[LineData]) {
        
        var allDatas = historyDayList()
        
        var mList = [LineData]()
        var wList = [LineData]()
        
        for var i:Int = 0;i<allDatas.count;i++ {
            var item = allDatas[i]
            var mData = LineData()
            
            var title = ""
            var dayArr = item.day.componentsSeparatedByString("-")
            title=dayArr[1]+"-"+dayArr[2]
            
            mData.title=title
            mData.value=CGFloat(item.milkCount)
            mData.type="奶粉"
            
            var wData = LineData()
            wData.title=title
            wData.value=CGFloat(item.waterCount)
            wData.type="开水"

            mList.append(mData)
            wList.append(wData)
            
            if i == 6{
                break
            }
        }
        
        return (mList,wList)
    }
    
}