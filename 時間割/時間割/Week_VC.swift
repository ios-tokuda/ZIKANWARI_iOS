//
//  ViewController.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/01.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import UIKit
import RealmSwift

class Week_VC: UIViewController {
    
    public let WEEK_DAYS :[String] = ["日", "月", "火", "水", "木", "金", "土"]
    

    

    
    //設定で変更可能にしたい。
    var Len_H:Int = 5  //時間割縦数
    var Len_V:Int = 5     //時間割横数
    let haba:CGFloat = 40  //端のラベルの幅
    let edge_NC:CGFloat = 64 //ナビゲーションコントローラの下端の座標 全端末共通
    let space:CGFloat = 1   //ラベル間の隙間の幅
    var nowDay:Int = 0  //今の曜日
    
    
    
    // デフォルトRealmを取得
    let realm:Realm = try! Realm()
    
    //ナビゲーションボタンの生成
    private var myLeftButton: UIBarButtonItem!
    private var myRightButton: UIBarButtonItem!
    
    
    
    //deligateにおいてあるメンバにはここからアクセス
    //VCをまたいで値を渡したい時などに用いる
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*try! realm.write {
            realm.deleteAll()
        }*/
        
        //let TT:TimeTable = TimeTable();
        

        
        
        
        /*let TT:TimeTable = TimeTable();
        TT.Name = "多変量解析"
        TT.Teacher = "上浦"
        TT.Tag = 12
        try! realm.write {
            realm.add(TT, update: true)
        }*//////
        
        //左ボタンを作成する
        myLeftButton = UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(Week_VC.onClickMyButton(sender:)))
        myLeftButton.tag = 100
        //右ボタンを作成する
        myRightButton = UIBarButtonItem(title: "設定", style: .plain, target: self, action: #selector(Week_VC.onClickMyButton(sender:)))
        
        
        //編集ボタンをナビゲーションバーの右に設置する
        self.navigationItem.leftBarButtonItem = myLeftButton
        //設定ボタンをナビゲーションバーの右に設置する
        self.navigationItem.rightBarButtonItem = myRightButton
        
        
        //設定を読み込ませたい
        self.Len_V = 5
        self.Len_H = 5
        
        //今を取得
        let now = Date()
        let calendar = Calendar.current
        
        // 設定されたタイトルを代入するとナビゲーションコントローラに反映される。
        self.title = String(calendar.component(.month, from: now)) + "月" + String(calendar.component(.day, from: now)) + "日 " + self.WEEK_DAYS[calendar.component(.weekday, from: now) - 1] + "曜日"
        //端のラベルを表示
        self.drawEdgeLabels();
        //時間割のボタンを表示
        self.drawTTButtons()
        // 背景色
        self.view.backgroundColor = self.delegate.BGColor
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //時間割端のラベルを表示。
    func drawEdgeLabels(){
        for i in 0..<Len_V{
            // ボタンのサイズを定義.
            let bWidth: CGFloat = self.haba - self.space
            let bHeight: CGFloat = CGFloat(CGFloat(view.bounds.height - self.haba - self.edge_NC)/CGFloat(Len_V)) - self.space
            // 配置する座標を定義
            let posX: CGFloat = 0
            let posY: CGFloat = self.edge_NC + self.haba + CGFloat(i)*(bHeight + self.space)
            
            // Labelを作成.
            let label: UILabel = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
            
            // UILabelの背景
            label.backgroundColor = self.delegate.LColorN
            
            
            // 文字の色を白に定義.
            label.textColor = UIColor.white
            
            // UILabelに文字を代入.
            label.text = String(i+1)
            
            // Textを中央寄せにする.
            label.textAlignment = NSTextAlignment.center
            
            // ViewにLabelを追加.
            self.view.addSubview(label)
        }
        for i in 0..<Len_H{
            // ボタンのサイズを定義.
            let bWidth: CGFloat = CGFloat(CGFloat(view.bounds.width - self.haba)/CGFloat(Len_H)) - self.space
            let bHeight: CGFloat = self.haba - self.space
            // 配置する座標を定義
            let posX: CGFloat = self.haba + CGFloat(i)*(bWidth + self.space)
            let posY: CGFloat = self.edge_NC
            
            // Labelを作成.
            let label: UILabel = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
            
            // UILabelの背景を灰色に.
            if (Calendar.current.component(.weekday, from: Date()) - 2) == i{
                label.backgroundColor = self.delegate.LColorPU
            }else{
                label.backgroundColor = self.delegate.LColorN
            }
            
            // 文字の色を白に定義.
            label.textColor = UIColor.white
            
            // UILabelに文字を代入.
            label.text = self.WEEK_DAYS[i + 1]
            
            // Textを中央寄せにする.
            label.textAlignment = NSTextAlignment.center
            
            // ViewにLabelを追加.
            self.view.addSubview(label)
        }
    }
    
    
    
    func drawTTButtons(){
        
        
        for i in 0..<Len_V{
            for j in 0..<Len_H{
                // ボタンに対応するTimeTableを取得
                let TableList:Results<TimeTable> = self.realm.objects(TimeTable.self).filter("Tag == " + (String)(j + 10 * i))
                
                
                let ttButton: UIButton! = UIButton()
                // ボタンのサイズを定義.
                let bWidth: CGFloat = CGFloat(CGFloat(view.bounds.width - self.haba)/CGFloat(Len_H)) - self.space
                let bHeight: CGFloat = CGFloat(CGFloat(view.bounds.height - self.haba - self.edge_NC)/CGFloat(Len_V)) - self.space
                // 配置する座標を定義
                let posX: CGFloat = self.haba + CGFloat(j)*(bWidth + self.space)
                let posY: CGFloat = self.edge_NC + self.haba + CGFloat(i)*(bHeight + self.space)
                
                // Labelを作成.
                ttButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
                
                
                // UILabelの背景を白色に.
                ttButton.backgroundColor = UIColor.white
                
                //labelの枠線
                ttButton.layer.borderColor = UIColor.gray.cgColor
                ttButton.layer.borderWidth = 1.0;
                
                // タイトルを設定する
                //ついでに同一タグのがあったら他のを消し飛ばす
                if TableList.count > 0 {
                    ttButton.setTitle(TableList[0].Name, for: .normal)
                    ttButton.setTitle(TableList[0].Name, for: .highlighted)
                    if TableList.count > 1{//余計なデータがあった場合
                        for k in 1..<TableList.count{//消します。
                            print("わかめ")
                            try! realm.write {
                                realm.delete(TableList[k])
                            }
                        }
                    }
                }
                
                ttButton.setTitleColor(UIColor.black, for: .normal)
                ttButton.setTitleColor(UIColor.black, for: .highlighted)
                
                // イベントを追加する
                ttButton.addTarget(self, action: #selector(self.onClickMyButton(sender:)), for: .touchUpInside)
                
                // ボタンにタグをつける.
                ttButton.tag = j + 10 * i
                
                
                // ViewにBottunを追加.
                self.view.addSubview(ttButton)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ボタンが押された時の処理。
    internal func onClickMyButton(sender: UIButton) {
        print("onClickMyButton:");
        print("sender.tag: \(sender.tag)")
        
        self.delegate.tag = sender.tag
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = One_VC()
        // Viewの移動する.
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
    }
    
}

