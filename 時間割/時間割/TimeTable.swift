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
class TimeTable :Object {
    public dynamic var Name:String = "" //講義名
    public dynamic var Teacher:String = ""  //先生
    public dynamic var tag:Int = -1 //タグ
    
    
    /*init(Name:String, Teacher:String, tag:Int){
        self.Name = Name
        self.Teacher = Teacher
        self.tag = tag
    }*/

    public func Save(){
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
}

class HomeWork :Object{
    public dynamic var Tag:Int = -1
    public dynamic var Name:String = ""
    public dynamic var Memo:String = ""
    public dynamic var NTime:Date? = nil
    
}
