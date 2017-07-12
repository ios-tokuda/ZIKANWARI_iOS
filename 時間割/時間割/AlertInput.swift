//
//  AlertInput.swift
//  時間割
//
//  Created by 沼田悠貴 on 2017/05/28.
//  Copyright © 2017年 浅見朋. All rights reserved.
//
import UIKit
import RealmSwift

class AlertInput: UIAlertController
{
    var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var tag:Int = -1
    
    var temp = [""]
    
    // デフォルトRealmを取得
    let realm:Realm = try! Realm()

    
    func OneInput(one:One_VC){
        
        //課題編集でこのメソッドが呼ばれた場合に必要
        let current:Results<HomeWork> = self.realm.objects(HomeWork.self).filter("Id == " + (String)(self.delegate.ID))

        
        // フォーマットを生成.
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.locale = Locale(identifier: "ja_JP_POSIX")
        myDateFormatter.dateFormat = "MM/dd hh:mm"
        
        let alertCtr = UIAlertController(title: "課題",
                                         message: "入力してください",
                                         preferredStyle: .alert)
        
        
        
        // テキストフィールドを追加
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "テキスト"
            if self.delegate.ID != -1{  //編集で呼ばれた場合
                textField.text = current[0].Name    //編集している課題名を予め代入する
            }
            
        })
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "日時"
            if self.delegate.ID != -1{  //編集で呼ばれた場合
                textField.text = current[0].NTimeString     //編集している提出期限を予め代入する
            }else{                      //編集で呼ばれてない場合
                //現在時刻を予め代入する
                let now = Date()
                textField.text = myDateFormatter.string(for: now)
            }
        })
        
        var textFields = alertCtr.textFields
        one.textField = textFields?[1]
        textFields?[1].inputView = one.vi
        textFields?[1].inputAccessoryView = one.toolBar
        
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "追加",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("追加")
                                                        // 追加を押した時入力されていたテキストを表示
                                                        if let textFields = alertCtr.textFields {
                                                            
                                                            // アラートに含まれるすべてのテキストフィールドを調べる
                                                            //for textField in textFields {
                                                                //self.delegate.taskName = textField.text!
                                                                //one.taskName.append(textField.text!)
                                                                one.taskN = textFields[0].text!
                                                                
                                                                one.taskExist = true    //バグ(1)解決のための苦肉の策
                                                                self.delegate.ID = -1
                                                                one.createSection()

                                                                print(textFields[0].text!)
                                                            //}
                                                        }
                                                        
        })
        
        /*let timeAction:UIAlertAction = UIAlertAction(title: "日時",
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            print("日時")
                                                            
                                                            one.sendPickTime()
        })*/
        
        let destructiveAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                            style: UIAlertActionStyle.destructive,
                                                            handler:{
                                                                (action:UIAlertAction!) -> Void in
                                                                print("Cancel")
        })
        
        alertCtr.addAction(cancelAction)
        //alertCtr.addAction(timeAction)
        alertCtr.addAction(destructiveAction)
        
        one.present(alertCtr, animated: true, completion: nil)
    }
    
    func WeekInput(week:Week_VC)
    {
        let alertCtr = UIAlertController(title: "編集",
                                         message: "入力してください",
                                         preferredStyle: .alert)
    
        //現在のタグが示すTimeTableを取得する
        let Current:Results<TimeTable> = self.realm.objects(TimeTable.self).filter("Tag == " + (String)(self.delegate.tag))
        
        // テキストフィールドの追加
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "教科"
            //タグに対応したTimeTableが存在するならばその値を入力欄に予め代入しておく
            if Current.count != 0{
                textField.text = Current[0].Name
            }
        })
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "講師"
            if Current.count != 0{
                textField.text = Current[0].Teacher
            }
        })
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "教室"
            if Current.count != 0{
                textField.text = Current[0].Room
            }
        })
        
        //追加ボタンの追加
        let addAction:UIAlertAction = UIAlertAction(title: "追加",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("追加")
                                                        // 追加を押した時入力されていたテキストを表示
                                                        if let textFields = alertCtr.textFields {
                                                            // アラートに含まれるすべてのテキストフィールドを調べる
                                                            for textField in textFields {
                                                                print(textField.text!)
                                                                //与えられるすべてをtempの配列にそれぞれ格納する
                                                                self.temp.append(textField.text!)
                                                            }
                                                            //格納されたtempの値をWeek_VCの各変数に代入する
                                                            week.className = self.temp[1]
                                                            week.teachName = self.temp[2]
                                                            week.classRoomName = self.temp[3]
                                                            
                                                            week.createCurriculum()
                                                        }
        })
        
        //キャンセルボタンの追加
        let destructiveAction: UIAlertAction = UIAlertAction(title: "Cancel",
                                                             style: UIAlertActionStyle.destructive,
                                                             handler:{
                                                                (action:UIAlertAction!) -> Void in print("Cancel")
        })
        
        //ボタンの表示
        alertCtr.addAction(addAction)
        alertCtr.addAction(destructiveAction)
        
        week.present(alertCtr, animated: true, completion: nil)
        
    }
    
    //編集するか消去するかを選択する
    func SelectWeek(week: Week_VC)
    {
        self.tag = self.delegate.tag
        let alertCtr = UIAlertController(title: "どうする？",
                                         message: "選択してください",
                                         preferredStyle: .alert)
        
        let addAction:UIAlertAction = UIAlertAction(title: "編集",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("編集")
                                                        
                                                        self.WeekInput(week: week)
                                                        
        })
        
        let deleteAction:UIAlertAction = UIAlertAction(title: "消去",
                                                     style: UIAlertActionStyle.destructive,
                                                     handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("消去")
                                                        
                                                        week.wDelete = true
                                                        
                                                        week.createCurriculum()
                                                        
                                                        
        })
        
        alertCtr.addAction(addAction)
        alertCtr.addAction(deleteAction)

        week.present(alertCtr, animated: true, completion: nil)
    }
    
    
    
    //編集するか消去するかを選択する
    func SelectOne(one: One_VC)
    {
        self.tag = self.delegate.tag
        let alertCtr = UIAlertController(title: "どうする？",
                                         message: "選択してください",
                                         preferredStyle: .alert)
        
        let addAction:UIAlertAction = UIAlertAction(title: "編集",
                                                    style: UIAlertActionStyle.cancel,
                                                    handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("編集")
                                                        
                                                        self.OneInput(one : one)
                                                        
        })
        
        let deleteAction:UIAlertAction = UIAlertAction(title: "消去",
                                                       style: UIAlertActionStyle.destructive,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("消去")
                                                        
                                                        let current:Results<HomeWork> = self.realm.objects(HomeWork.self).filter("Id == " + (String)(self.delegate.ID))
                                                        
                                                        try! self.realm.write {
                                                            self.realm.delete(current)
                                                        }
                                                        self.delegate.ID = -1
                                                        one.createSection()
                                                        
                                                        
        })
        
        alertCtr.addAction(addAction)
        alertCtr.addAction(deleteAction)
        
        one.present(alertCtr, animated: true, completion: nil)
    }

    
}
