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
    let ttInfoLabelHight:CGFloat = 20   //時間割の教室やらを表示するラベルの高さ。
    
    
    
    
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
        
        //試験運用する際に使用してください
        let TT:TimeTable = TimeTable();
        TT.Name = "多変量解析"
        TT.Teacher = "上浦"
        TT.Room = "6103"
        TT.Tag = 12
        try! realm.write {
            realm.add(TT, update: true)
         
        }
        
        let HW:HomeWork = HomeWork()
        HW.Id = 1
        HW.Tag = 12
        HW.Name = "中間レポート"
        HW.Memo = "めんどいのではよ進めろ"
        HW.isFinished = false
        try! realm.write {
            realm.add(HW, update: true)
            
        }
        
        
        //左ボタンを作成する
        myLeftButton = UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(self.EditButton(sender:)))
        myLeftButton.tag = 100
        //右ボタンを作成する
        myRightButton = UIBarButtonItem(title: "設定", style: .plain, target: self, action: #selector(self.ControlButton(sender:)))
        
        
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
                
                let WorkList:Results<HomeWork> = self.realm.objects(HomeWork.self).filter("Tag == " + (String)(j + 10 * i))
                let ttButton: UIButton! = UIButton()
                
                // ボタンのサイズを定義.
                let bWidth: CGFloat = CGFloat(CGFloat(view.bounds.width - self.haba)/CGFloat(Len_H)) - self.space
                let bHeight: CGFloat = CGFloat(CGFloat(view.bounds.height - self.haba - self.edge_NC)/CGFloat(Len_V)) - self.space
                // 配置する座標を定義
                let posX: CGFloat = self.haba + CGFloat(j)*(bWidth + self.space)
                let posY: CGFloat = self.edge_NC + self.haba + CGFloat(i)*(bHeight + self.space)
                
                // Labelを作成.
                ttButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight-ttInfoLabelHight)
                ttButton.titleLabel?.adjustsFontSizeToFitWidth = true
                
                // UILabelの背景を白色に.
                ttButton.backgroundColor = UIColor.white
                if WorkList.count > 0{
                    for k in 0..<WorkList.count{
                        if !(WorkList[k].isFinished){
                            ttButton.backgroundColor = self.delegate.LColorPU
                            break
                        }
                    }
                }
                //buttonの枠線
                ttButton.layer.borderColor = UIColor.gray.cgColor
                ttButton.layer.borderWidth = 1.0;
                
                
                
                // ボタンのサイズを定義.
                let lWidth: CGFloat = bWidth
                let lHeight: CGFloat = ttInfoLabelHight
                // 配置する座標を定義
                let lposX: CGFloat = posX
                let lposY: CGFloat = posY + bHeight - ttInfoLabelHight
                
                // Labelを作成.
                let label: UILabel = UILabel(frame: CGRect(x: lposX, y: lposY, width: lWidth, height: lHeight))
                
                // UILabelの背景
                label.backgroundColor = UIColor.white
                label.adjustsFontSizeToFitWidth = true

                
                
                
                // 文字の色を黒に定義.
                label.textColor = UIColor.black
                
                label.adjustsFontSizeToFitWidth = true
                
                label.layer.borderColor = UIColor.gray.cgColor
                label.layer.borderWidth = 1.0;

                
                
                // タイトルを設定する
                //ついでに同一タグのがあったら他のを消し飛ばす
                if TableList.count > 0 {
                    ttButton.setTitle(TableList[0].Name, for: .normal)
                    ttButton.setTitle(TableList[0].Name, for: .highlighted)
                    // UILabelに文字を代入.
                    label.text = TableList[0].Room  //String(i+1)
                    if TableList.count > 1{//余計なデータがあった場合
                        for k in 1..<TableList.count{//消します。
                            print("余計なものがあった")
                            try! realm.write {
                                realm.delete(TableList[k])
                            }
                        }
                    }
                }
                
                ttButton.setTitleColor(UIColor.black, for: .normal)
                ttButton.setTitleColor(UIColor.black, for: .highlighted)
                
                
                
                // Textを中央寄せにする.
                label.textAlignment = NSTextAlignment.center
                
                // ViewにLabelを追加.
                self.view.addSubview(label)
                
                
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
    //編集ボタンが押されたとき
    internal func EditButton(sender: UIButton){
        print("編集ボタンが押されました");
    }
    //設定ボタンが押されたとき
    internal func ControlButton(sender: UIButton){
        print("設定ボタンが押されました");
    }
    
    
}

