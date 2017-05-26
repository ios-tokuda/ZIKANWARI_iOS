//
//  TimeTable.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/02.
//  Copyright © 2017年 浅見朋. All rights reserved.
//
import Foundation
import RealmSwift

class Data:Object{
    dynamic var Tag:Int = -1 //タグ
    func Add(){
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
}


//このクラスを保存する(?)
class TimeTable :Data {
    dynamic var Name:String = "" //講義名
    dynamic var Teacher:String = ""  //先生
}


class HomeWork :Data{
    dynamic var Name:String = ""
    dynamic var Memo:String = ""
    dynamic var NTime:Date? = nil
}
