//
//  AllTask.swift
//  時間割
//
//  Created by 沼田悠貴 on 2017/07/07.
//  Copyright © 2017年 浅見朋. All rights reserved.
//


//全課題をテーブルにずらずらと表示する

import UIKit
import RealmSwift

class AllTask: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var myTableView: UITableView!
    
    
    // デフォルトRealmを取得
    let realm:Realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成(Status barの高さをずらして表示).
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight))
        
        // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceを自身に設定する.
        myTableView.dataSource = self
        
        // Delegateを自身に設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     Cellが選択された際に呼び出される
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
    }
    
    /*
     Cellの総数を返す.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let WorkList:Results<HomeWork> = self.realm.objects(HomeWork.self)
        return WorkList.count
    }
    
    /*
     Cellに値を設定する
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得する.
        
        //講義名を表示するため
        let currentTable:Results<TimeTable>!
        
        //課題名を表示するため
        let WorkList:Results<HomeWork> = self.realm.objects(HomeWork.self)
        let FirstList:Results<HomeWork> = WorkList.filter("isFinished == false").sorted(byKeyPath: "NTime", ascending: true)
        let LateList:Results<HomeWork> = WorkList.filter("isFinished == true").sorted(byKeyPath: "NTime", ascending: true)
        
        //現在の課題を表示する
        var currentTask:HomeWork!
        if indexPath.row < FirstList.count{
            currentTask = FirstList[indexPath.row]
        }else{
            currentTask = LateList[indexPath.row - FirstList.count]
        }
        
        currentTable = self.realm.objects(TimeTable.self).filter("Tag == " + (String)(currentTask.Tag))
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(currentTable[0].Name)"
        cell.detailTextLabel?.text = currentTask.Name

        
        return cell
    }
    
}
