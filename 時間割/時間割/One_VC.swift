//
//  One_VC.swift
//  時間割
//
//  Created by 沼田悠貴 on 2017/05/15.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import UIKit

class One_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Tableで使用する配列を定義する.
    var classRoomName: Array = ["331"]            //クラスの場所
    var teachName: Array = ["我妻"]             //講師の名前
    var timeName: Array = ["16:40~"]          //授業時間
    var taskName: [String] = ["課題"]         //課題を入れていく
    var deadline: [String] = [""]             //
    
    var taskN = "!!!"
    
    //private let myiPhoneItems: NSArray = ["iOS9","iOS8", "iOS7", "iOS6", "iOS5", "iOS4"]
    //private let myAndroidItems: NSArray = ["5.x", "4.x", "2.x", "1.x"]
    
    
    // Sectionで使用する配列を定義する.
    private let mySections: NSArray = ["教室", "講師", "時間", "課題"]

    
    
    
    var inputKadai: UITextView!
    
    //deligateにおいてあるメンバにはここからアクセス
    //VCをまたいで値を渡したい時などに用いる
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    let edge_NC:CGFloat = 64 //ナビゲーションコントローラの下端の座標 全端末共通
    
    var tag:Int = -1
    
    //ナビゲーションボタンの生成
    private var myRightButton: UIBarButtonItem!
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tag = self.delegate.tag
                print("sender.tag: \(self.tag)")
        
        
        //NavigationControllerのタイトルを設定する
        self.title = "講義名"
        
        //右ボタンを作成する
        myRightButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(One_VC.onClickMyButton(sender:)))
        
        //ナビゲーションバーの右に設置する
        self.navigationItem.rightBarButtonItem = myRightButton
        
        
        self.view.backgroundColor = UIColor.red
        
        self.createSection()

        /*
        // 背景色
        self.view.backgroundColor = self.delegate.BGColor
        
        // Status Barの高さを取得をする.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成( status barの高さ分ずらして表示 ).
        let myTableView: UITableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
 */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recrp0eated.
    }
    
    
    
    //+ボタンが押された時のイベント
    internal func onClickMyButton(sender: UIButton){
        AlertInput().OneInput(one: self)
        
        //self.taskN = self.delegate.taskName
        print(taskN)
        
        //self.taskName.append(self.delegate.taskName)
    }

    //課題セクションを作成(課題の変更を更新)
    func createSection()
    {
        // 背景色
        self.view.backgroundColor = self.delegate.BGColor
        
        // Status Barの高さを取得をする.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成( status barの高さ分ずらして表示 ).
        let myTableView: UITableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)

    }
    
    
    //セクションの数を返す.
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    
    
    //セクションのタイトルを返す.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section] as? String
    }
    
    
    //Cellが選択された際に呼び出される.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("Value: \(classRoomName[indexPath.row])")
        } else if indexPath.section == 1 {
            print("Value: \(teachName[indexPath.row])")
        } else if indexPath.section == 2 {
            print("Value: \(timeName[indexPath.row])")
        } else if indexPath.section == 3 {
            print("Value: \(taskName[indexPath.row])")
        }
    }
    
    
    //テーブルに表示する配列の総数を返す.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return classRoomName.count
        } else if section == 1 {
            return teachName.count
        } else if section == 2 {
            return timeName.count
        } else if section == 3
        {
            return taskName.count
        }else {
            return 0
        }
    }
    
    //Cellに値を設定する.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(classRoomName[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(teachName[indexPath.row])"
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "\(timeName[indexPath.row])"
        } else if indexPath.section == 3 {
            cell.textLabel?.text = "\(taskName[indexPath.row])"
        }
        
        return cell
    }
    
    func sendPickTime()
    {
        // 遷移するViewを定義する.
        let picktime: UIViewController = PickTime()
        // Viewの移動する.
        self.navigationController?.pushViewController(picktime, animated: true)
        

    }
    
}

//課題追加に関する入出力を行なうクラス
/*
class AlertInput: UIAlertController
{
    var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func OneInput(one:One_VC, time: pickTime){
        
        let alertCtr = UIAlertController(title: "課題",
                                         message: "入力してください",
                                         preferredStyle: .alert)
        
        // テキストフィールドを追加
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "テキスト"
        })
        
        
        
        let timeAction:UIAlertAction = UIAlertAction(title: "期限",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("期限")
                                                        // 追加を押した時入力されていたテキストを表示
                                                        if let textFields = alertCtr.textFields {
                                                            
                                                            // アラートに含まれるすべてのテキストフィールドを調べる
                                                            for textField in textFields {
                                                                self.delegate.taskName = textField.text!
                                                                vc.taskName.append(textField.text!)
                                                                time.selectTime()
                                                                print(textField.text!)
                                                            }
                                                        }
                                                        
        })
        
        let destructiveAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                            style: UIAlertActionStyle.destructive,
                                                            handler:{
                                                                (action:UIAlertAction!) -> Void in
                                                                print("Cancel")
        })
        
        //ボタンの追加
        alertCtr.addAction(timeAction)
        alertCtr.addAction(destructiveAction)
        
        //指定されたViewControllerにアラートを表示する
        vc.present(alertCtr, animated: true, completion: nil)
    }

}

class pickTime: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // UIPickerView.
    private var myUIPicker: UIPickerView!
    
    // 表示する値の配列.
    private let myValues: NSArray = ["その一","その二","その三","その四"]
    
    func selectTime(vc: One_VC) {
        
        // UIPickerViewを生成.
        myUIPicker = UIPickerView()
        
        // サイズを指定する.
        myUIPicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 180.0)
        
        // Delegateを設定する.
        myUIPicker.delegate = self
        
        // DataSourceを設定する.
        myUIPicker.dataSource = self
        
        // Viewに追加する.
        self.view.addSubview(myUIPicker)
        
        vc.createSection()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
     pickerに表示する行数を返すデータソースメソッド.
     (実装必須)
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myValues.count
    }
    
    /*
     pickerに表示する値を返すデリゲートメソッド.
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myValues[row] as? String
    }
    
    /*
     pickerが選択された際に呼ばれるデリゲートメソッド.
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(myValues[row])")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
 */


