//
//  AlertInput.swift
//  時間割
//
//  Created by 沼田悠貴 on 2017/05/28.
//  Copyright © 2017年 浅見朋. All rights reserved.
//
import UIKit

class AlertInput: UIAlertController
{
    var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var tag:Int = -1
    
    var temp = [""]
    
    
    func OneInput(one:One_VC){
        
        let alertCtr = UIAlertController(title: "課題",
                                         message: "入力してください",
                                         preferredStyle: .alert)
        
        // テキストフィールドを追加
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "テキスト"
        })
        
        
        
        /*let cancelAction:UIAlertAction = UIAlertAction(title: "追加",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("追加")
                                                        // 追加を押した時入力されていたテキストを表示
                                                        if let textFields = alertCtr.textFields {
                                                            
                                                            // アラートに含まれるすべてのテキストフィールドを調べる
                                                            for textField in textFields {
                                                                //self.delegate.taskName = textField.text!
                                                                one.taskName.append(textField.text!)
                                                                one.createSection()

                                                                print(textField.text!)
                                                            }
                                                        }
                                                        
        })*/
        
        /*let timeAction:UIAlertAction = UIAlertAction(title: "日時",
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            print("日時")
                                                            //PickTimeへ遷移するメソッド
                                                            one.sendPickTime()
        })*/
        
        let destructiveAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                            style: UIAlertActionStyle.destructive,
                                                            handler:{
                                                                (action:UIAlertAction!) -> Void in
                                                                print("Cancel")
        })
        
        //alertCtr.addAction(cancelAction)
        //alertCtr.addAction(timeAction)
        alertCtr.addAction(destructiveAction)
        
        one.present(alertCtr, animated: true, completion: nil)
    }
    
    func WeekInput(week:Week_VC)
    {
        let alertCtr = UIAlertController(title: "編集",
                                         message: "入力してください",
                                         preferredStyle: .alert)
        
        // テキストフィールドの追加
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "教科"})
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "講師"})
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "教室"})
        
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
                                                            week.classRoomName = self.temp[2]
                                                            week.teachName = self.temp[3]
                                                            
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
    
}
