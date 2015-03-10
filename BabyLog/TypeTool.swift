//
//  type.swift
//  BabyLog
//
//  Created by mj.zhou on 15/3/7.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import Foundation

class TypeTool {
    class func typeToTitle(type:Int)->String {
        if type == 0 {
            return "奶粉"
        }
        if type == 1 {
            return "开水"
        }
        if type == 2 {
            return "便便"
        }
        return ""
    }
}