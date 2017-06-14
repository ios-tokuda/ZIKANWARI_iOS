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
    var className: Array = ["331"]            //クラスの場所
    var teachName: Array = ["我妻"]             //講師の名前
    var timeName: Array = ["16:40~"]          //授業時間
    var taskName: [String] = []                  //課題を入れていく
    
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
        
        //ナビゲー１ションバーの右に設置する
        self.navigationItem.rightBarButtonItem = myRightButton
        
        
        self.view.backgroundColor = UIColor.red
        
        

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recrp0eated.
    }
    
    
    /*
     +ボタンが押された時のイベント
     */
    internal func onClickMyButton(sender: UIButton){
        let showInput = AlertInput().OneInput(one: self)
        
        //self.taskN = self.delegate.taskName
        print(taskN)
        print(taskN)
        print(taskN)
        print(taskN)
        //self.taskName.append(self.delegate.taskName)
        self.view.backgroundColor = UIColor.red
    }

    
    /*
     セクションの数を返す.
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    
    /*
     セクションのタイトルを返す.
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section] as? String
    }
    
    /*
     Cellが選択された際に呼び出される.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("Value: \(className[indexPath.row])")
        } else if indexPath.section == 1 {
            print("Value: \(teachName[indexPath.row])")
        } else if indexPath.section == 2 {
            print("Value: \(timeName[indexPath.row])")
        } else if indexPath.section == 3 {
            print("Value: \(taskName[indexPath.row])")
        }
    }
    
    /*
     テーブルに表示する配列の総数を返す.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return className.count
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
    
    /*
     Cellに値を設定する.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(className[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(teachName[indexPath.row])"
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "\(timeName[indexPath.row])"
        } else if indexPath.section == 3 {
            cell.textLabel?.text = "\(taskName[indexPath.row])"
        }
        
        return cell
    }
    
}



