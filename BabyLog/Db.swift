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
    
    class func getDb()->FMDatabase{
    
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        
        var databasePath = docsDir.stringByAppendingPathComponent("feedlog.db")
        
        if !filemgr.fileExistsAtPath(databasePath) {
            
            let db = FMDatabase(path: databasePath)
            
            if db == nil {
                println("Error: \(db.lastErrorMessage())")
            }
            
            if db.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS FEEDLOGS (ID TEXT PRIMARY KEY, COUNT INTEGER, TYPE INTEGER,LOGTIME DATETIME,LOGDAY TEXT, REMARK TEXT)"
                if !db.executeStatements(sql_stmt) {
                    println("Error: \(db.lastErrorMessage())")
                }
                db.close()
            } else {
                println("Error: \(db.lastErrorMessage())")
            }
        }
        
        let feedlogDb = FMDatabase(path: databasePath)
        return feedlogDb
    }
    
    
    class func insert(log:FeedLog){
    
        let sql="INSERT INTO FEEDLOGS (ID,COUNT,TYPE,LOGTIME,LOGDAY,REMARK) "+"VALUES (?,?,?,?,?,?)"
        let db = getDb()
        db.executeUpdate(sql, withArgumentsInArray: [log.id,log.count,log.type,log.logTime,log.logDay,log.remark])
        db.close()
    }
    
   class func remove(id:String){
        let sql = "DELETE FROM FEEDLOGS WHERE ID = ?"
        let db = getDb()
        db.executeUpdate(sql, withArgumentsInArray: [id])
        db.close()
    }
    
   class func update(log:FeedLog){
        
        let sql = "UPDATE FEEDLOGS SET COUNT=?,TYPE=?,LOGTIME=?,LOGDAY=?,REMARK=? WHERE ID=?"
        let db = getDb()
        db.executeUpdate(sql, withArgumentsInArray: [log.count,log.type,log.logTime,log.logDay,log.remark,log.id])
        db.close()
    }
    
    class func select(id:String)->FeedLog?{
    
        let sql = "SELECT * FROM FEEDLOGS WHERE ID = ?"
        let db = getDb()
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
        let db = getDb()
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
        
        let sql = "SELECT LOGTIME FROM FEEDLOSG WHERE TYPE = ? ORDER BY LOGTIME DESC"
        let db = getDb()
        
        var date:NSDate?
        
        var rs = db.executeQuery(sql, withArgumentsInArray: [type])
        while rs.next(){
            date = rs.dateForColumn("LOGTIME")
        }
        
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
                shitCount+=tl.count
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
    
}