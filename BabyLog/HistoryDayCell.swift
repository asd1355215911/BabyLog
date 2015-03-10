//
//  HistoryDayCell.swift
//  BabyLog
//
//  Created by mj.zhou on 15/3/8.
//  Copyright (c) 2015年 mjstudio. All rights reserved.
//

import UIKit
class HistoryDayCell: UITableViewCell {
    @IBOutlet weak var detailText: UILabel!

    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var remarkText: UILabel!
    
    override  func layoutSubviews() {
        super.layoutSubviews()
        autoLayout()
    }
    
    func autoLayout()
    {
        let leftConstant:CGFloat = 15
        let c1 = NSLayoutConstraint(item: detailText,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: self,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: leftConstant)
        let c2 = NSLayoutConstraint(item: remarkText,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: self,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: leftConstant)
        let c3 = NSLayoutConstraint(item: timeText,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: self,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: leftConstant)
        
        let c4 = NSLayoutConstraint(item: detailText,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: self,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 2)
        let c5 = NSLayoutConstraint(item: remarkText,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: detailText,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 2)
        let c6 = NSLayoutConstraint(item: timeText,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: self,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 2)
        
        let widthConstant = self.contentView.bounds.width-leftConstant*2
        let c7 = NSLayoutConstraint(item: detailText,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.GreaterThanOrEqual,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant:widthConstant)
        let c8 = NSLayoutConstraint(item: remarkText,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.GreaterThanOrEqual,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant:widthConstant)
        let c9 = NSLayoutConstraint(item: timeText,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.GreaterThanOrEqual,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: widthConstant)
        
        self.addConstraint(c1)
        self.addConstraint(c2)
        self.addConstraint(c3)
        self.addConstraint(c4)
        self.addConstraint(c5)
        self.addConstraint(c6)
        
        self.addConstraint(c7)
        self.addConstraint(c8)
        self.addConstraint(c9)
        
        //w zhid a w self.view
    }
}
