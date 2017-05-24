//
//  TimeTable.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/02.
//  Copyright © 2017年 浅見朋. All rights reserved.
//
import UIKit
import Foundation
import RealmSwift


//このクラスを保存する(?)
class TimeTable :UIViewController, Object, UIAppllicationDelegate{
    var delegate: TimeDelegate!
    
    public dynamic var Name:String = "" //講義名
    public dynamic var Teacher:String = ""  //先生
    public dynamic var day:Day = nil    //曜日(月 = 0)
    public dynamic var time:Int = nil   //時限
    public dynamic var tag:Int = -1 //タグ
    
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func incert(Name:String, Teacher:String, day:Day, time:Int, tag:Int){
        self.Name = Name
        self.Teacher = Teacher
        self.day = day
        self.time = time
        self.tag = tag
    }
    
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
    public dynamic var NTime:Date = nil
    
}
