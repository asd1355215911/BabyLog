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
    
}