//
//  One_VC.swift
//  時間割
//
//  Created by 沼田悠貴 on 2017/05/15.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import UIKit

class One_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Tableで使用する配列を設定する
    private let myItems: NSArray = ["TEST1", "TEST2", "TEST3"]
    private var myTableView: UITableView!
    
    //deligateにおいてあるメンバにはここからアクセス
    //VCをまたいで値を渡したい時などに用いる
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let TT = TimeTable()
    let HW = HomeWork()
    
    let edge_NC:CGFloat = 64 //ナビゲーションコントローラの下端の座標 全端末共通
    
    var tag:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tag = self.delegate.tag
        
        //ナビゲーションコントーラーに反映
        self.title = "講義名"
        
        // 背景色
        self.view.backgroundColor = self.delegate.BGColor
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        
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
        print("Value: \(myItems[indexPath.row])")
    }
    
    /*
     Cellの総数を返す.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    /*
     Cellに値を設定する
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        
        return cell
    }
    
}
