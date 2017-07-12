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
    dynamic var Tag:Int = -1    //講義時限
    dynamic var Name:String = "" //講義名
    dynamic var Teacher:String = ""  //先生
    dynamic var Room:String = ""    //教室
    
    override static func primaryKey() -> String? {
        return "Tag"
    }
}


class HomeWork :Object{
    dynamic var Id:Int = -1 //各課題の識別
    dynamic var Tag:Int = -1    //対応する講義
    dynamic var Name:String = ""    //課題名
    dynamic var NTime:Date? = nil     //締め切り時刻
    dynamic var NTimeString:String = "" //締め切り期限(表示用)
    dynamic var isFinished:Bool = false //終わってるか否か
    
    override static func primaryKey() -> String? {
        return "Id"
    }
}
