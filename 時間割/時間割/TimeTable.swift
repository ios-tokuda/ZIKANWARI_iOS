//
//  TimeTable.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/02.
//  Copyright © 2017年 浅見朋. All rights reserved.
//
import Foundation
import RealmSwift


//このクラスを保存する(?)
class TimeTable :Object{
    dynamic var Tag:Int = -1
    dynamic var Name:String = "" //講義名
    dynamic var Teacher:String = ""  //先生
    
    override static func primaryKey() -> String? {
        return "Tag"
    }
}


class HomeWork :Object{
    dynamic var Id:Int = -1
    dynamic var Tag:Int = -1
    dynamic var Name:String = ""
    dynamic var Memo:String = ""
    dynamic var NTime:Date? = nil
    
    override static func primaryKey() -> String? {
        return "Id"
    }
}
