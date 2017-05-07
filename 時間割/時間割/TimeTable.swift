//
//  TimeTable.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/02.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import Foundation

public enum Day:String{
    case Sun = "日"
    case Mon = "月"
    case Tue = "火"
    case Wed = "水"
    case Thu = "木"
    case Fri = "金"
    case Sat = "土"
}

class TimeTable {
    public var Name:String
    public var Teacher:String
    public var day:Day
    public var time:Int
    
    init(Name:String, Teacher:String, day:Day, time:Int){
        self.Name = Name
        self.Teacher = Teacher
        self.day = day
        self.time = time
    }
}
