//
//  Setting.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/22.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import Foundation
import UIKit

let sectionTitle = ["曜日数", "時限", "通知", "その他"]
let sectionD = ["5", "6", "7"]
let sectionK = ["5", "6", "7", "8", "9"]
let sectionN = ["通知時刻の設定"]
let sectionO = ["初期化"]
let tableData = [sectionD, sectionK, sectionN, sectionO]

class Setting: UIViewController,  UITableViewDelegate, UITableViewDataSource{


    override func viewDidLoad() {
        super.viewDidLoad()

        let TableView = UITableView(frame: view.frame, style: .grouped)
        TableView.delegate = self
        TableView.dataSource = self
        view.addSubview(TableView)

        // 設定されたタイトルを代入するとナビゲーションコントローラに反映される。
        self.title = "設定"
        // 背景色
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.




    }
    func numberOfSections(in tableView: UITableView) -> Int{
        //セクションの個数
        return sectionTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //セクションごとの行数
        let sectionData = tableData[section]
        return sectionData.count
    }
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        //セクションのタイトル
        return sectionTitle[section]
    }
    //セルを作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData
        return cell
    }

    //行がタップされた際に実行される。
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = sectionTitle[indexPath.section]
        let sectionData = tableData[indexPath.section]
        let cellData = sectionData[indexPath.row]
        print("\(title) \(cellData)")
        //indexPath.scetion セクション番号
        //indexPath.row セクション内の行番号
        print("\(indexPath.row) \(indexPath.section)")
        //print("\(cellData.0)")
        let alert = UIAlertController(title:nil, message:nil, preferredStyle: .alert)
        
        alert.title = title + "の設定"
        
        
        
        
        //キャンセルボタンとその動作
        alert.addAction(
            UIAlertAction(
                title:"キャンセル",
                style: .cancel,
                handler:nil)
        )
        
        //セクションごとに異なる動作を行う
        switch indexPath.section {
            case 0:
                //確定ボタンとその動作
                alert.addAction(
                    UIAlertAction(
                        title:"確定",
                        style: .default,
                        handler:{(action) ->Void in
                            self.debug(action.title!)}
                    )
                )
                alert.message = "曜日数を" + cellData + "日に設定します。"
                //これいる？
                self.present(
                    alert,
                    animated: true,
                    completion:{
                        print("やったぜ。")
                    }
                )
            case 1:
                //確定ボタンとその動作
                alert.addAction(
                    UIAlertAction(
                        title:"確定",
                        style: .default,
                        handler:{(action) ->Void in
                            self.debug(action.title!)}
                    )
                )
                alert.message = "一日の時限数を" + cellData + "に設定します。"
                //これいる？
                self.present(
                    alert,
                    animated: true,
                    completion:{
                        print("やったぜ。")
                    }
                )
            case 3:
                //確定ボタンとその動作
                alert.addAction(
                    UIAlertAction(
                        title:"確定",
                        style: .default,
                        handler:{(action) ->Void in
                            self.debug(action.title!)}
                    )
                )
                alert.message = "設定、時間割、課題データを初期化します。"
                //これいる？
                self.present(
                    alert,
                    animated: true,
                    completion:{
                        print("やったぜ。")
                    }
                )
            //case 2:
                //なんかピッカー表示させる。
            
            
        default:
            print("即死です。")
        }

        
        
    }

    /*func weekSetting(_ msg:String){
        print(msg)
    }
    
    func zigensuSetting(_ msg:String){
        print(msg)
    }
    
    func reset(_ msg:String){
        print(msg)
    }*/
    
    func debug(_ msg:String){
        print(msg)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
