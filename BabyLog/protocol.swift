//
//  protocol.swift
//  BabyLog
//
//  Created by mj.zhou on 15/3/3.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import Foundation

protocol AddViewControllerDelegate{
    func setDate(date:NSDate)
    
    func getDate()->NSDate
}

protocol FirstViewControllerDelegate{
    func setLogDetail()
}