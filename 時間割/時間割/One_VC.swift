//
//  One_VC.swift
//  時間割
//
//  Created by 沼田悠貴 on 2017/05/15.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import UIKit
import RealmSwift

class One_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Tableで使用する配列を設定する
    var taskName: [String] = []
    var myTableView: UITableView!
    let imageNames = ["door2.jpg", "clock2.jpg", "hito2.jpg"]
    
    //セルに表示するテキストをいじるときのやつ
    let tempS = "おまけ"
    
    //課題が達成したかどうかの判別(最終的にはHomeWorkクラス作成)
    var finished = false
    
    var deadline: [String] = ["aaa"]             //
    
    var taskN = ""
    
    //Realmに保存された課題を入れる変数
    var WorkList:Results<HomeWork>!
    
    // デフォルトRealmを取得
    let realm:Realm = try! Realm()
    
    
    //バグ(1)セルが無いときにセルを追加するとずれる
    //バグ(1)解決のための変数
    var taskExist = false
    
    
    // Status Barの高さを取得をする.
    var barHeight: CGFloat!
    
    // Viewの高さと幅を取得する.
    var displayWidth: CGFloat!
    var displayHeight: CGFloat!
    
    
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
        
        // Status Barの高さを取得をする.
        barHeight = UIApplication.shared.statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        displayWidth = self.view.frame.width
        displayHeight = self.view.frame.height

        
        
        //右ボタンを作成する
        myRightButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(One_VC.onClickMyButton(sender:)))
        
        //ナビゲーションバーの右に設置する
        self.navigationItem.rightBarButtonItem = myRightButton
        
        
        self.createSection()
        
        self.createDisplay()

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

    //課題以外の表示部分の作成
    func createDisplay()
    {
        Appearance()
        
        Icon()
        
        cLabel()
        
    }
    
    //外枠より少し小さい内枠をあとからviewに追加することによって枠を作る
    func Appearance()
    {
        
        //外見の作成
        //外枠
        let frame : UIView = UIView(frame: CGRect(x: 0, y: barHeight+50, width: displayWidth, height: 100))
        //内枠
        let innerFrame : UIView = UIView(frame: CGRect(x: 5, y: barHeight+50, width: displayWidth-10, height: 95))
        //帯
        let band : UIView = UIView(frame: CGRect(x: 0, y: barHeight+150, width: displayWidth, height: 50))
        
        let oLine0 : UIView = UIView(frame: CGRect(x: 0, y: barHeight+150, width: displayWidth, height: 2))
        let oLine1 : UIView = UIView(frame: CGRect(x: 0, y: barHeight+195, width: displayWidth, height: 2))
        let oLine2 : UIView = UIView(frame: CGRect(x: 0, y: barHeight+200, width: displayWidth, height: 2))
        //それぞれの指定
        frame.backgroundColor = self.delegate.BGColor
        innerFrame.backgroundColor = UIColor.white
        band.backgroundColor = UIColor.white
        oLine0.backgroundColor = UIColor.black
        oLine1.backgroundColor = UIColor.black
        oLine2.backgroundColor = UIColor.black
        
        
        //外枠と内枠をviewに追加する
        self.view.addSubview(frame)
        self.view.addSubview(innerFrame)
        self.view.addSubview(band)
        self.view.addSubview(oLine0)
        self.view.addSubview(oLine1)
        self.view.addSubview(oLine2)

    }
    
    //アイコンの表示
    func Icon()
    {
        // 講師用、教室用、授業時間用の画像をそれぞれ設定する.
        let hitoIcon: UIImage = UIImage(named: "hito2.jpg")!
        let doorIcon: UIImage = UIImage(named: "door2.jpg")!
        let clockIcon: UIImage = UIImage(named: "clock2.jpg")!
        
        //各アイコンの大きさ
        let imageWidth: CGFloat = 50
        let imageHeight: CGFloat = 50
        
        // それぞれのアイコンの表示用のUIImageViewを生成.
        let hitoDownView: UIImageView = UIImageView(frame:  CGRect(x: 10, y: barHeight+50, width: imageWidth, height: imageHeight))
        let doorDownView: UIImageView = UIImageView(frame: CGRect(x: 200, y: barHeight+50, width: imageWidth, height: imageHeight))
        let clockDownView: UIImageView = UIImageView(frame: CGRect(x: 10, y: barHeight+95, width: imageWidth, height:imageHeight))
        
        // UIImageViewにそれぞれのアイコンの画像を設定する.
        hitoDownView.image = hitoIcon
        doorDownView.image = doorIcon
        clockDownView.image = clockIcon
        
        // 縮小用(0.5倍)のアフィン行列を生成する.
        hitoDownView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        doorDownView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        clockDownView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        // Viewに追加する.
        self.view.addSubview(hitoDownView)
        self.view.addSubview(doorDownView)
        self.view.addSubview(clockDownView)

    }
    
    //ラベルとタイトルの表示
    func cLabel()
    {
        
        //現在のタグと一致するTimeTableを呼び出す
        let table:Results<TimeTable> = self.realm.objects(TimeTable.self).filter("Tag == " + (String)(self.tag))
        print(table[0].Name)
        
        //呼び出されたそれぞれの値を代入する(そのまま使おうとするとエラーが起こったため)
        let titleName = table[0].Name
        let teachName = table[0].Teacher
        let roomName = table[0].Room
        //let timeName =
        
        
        //NavigationControllerのタイトルを設定する
        self.title = titleName

        
        // 各項目のLabelを作成.
        let hitoLabel: UILabel = UILabel(frame: CGRect(x: 55, y: barHeight+50, width: 200, height: 50))
        let doorLabel: UILabel = UILabel(frame: CGRect(x: 245, y: barHeight+50, width: 200, height: 50))
        let clockLabel: UILabel = UILabel(frame: CGRect(x: 55, y: barHeight+95, width: 200, height: 50))
        
        let taskLabel: UILabel = UILabel(frame: CGRect(x: 73, y: barHeight+150, width: 200, height:50))
        let timeLabel: UILabel = UILabel(frame: CGRect(x: 275, y: barHeight+150, width: 200, height: 50))
        
        //ラベルに文字を代入
        hitoLabel.text = teachName
        doorLabel.text = roomName
        clockLabel.text = "9:30 ~ 11:00"
        taskLabel.text = "課題"
        timeLabel.text = "提出期限"
        
        // ViewにLabelを追加.
        self.view.addSubview(hitoLabel)
        self.view.addSubview(doorLabel)
        self.view.addSubview(clockLabel)
        self.view.addSubview(taskLabel)
        self.view.addSubview(timeLabel)

    }
    
    //課題セクションを作成(課題の変更を更新)
    func createSection()
    {
        
        //タグが初期値でなければRealmに値を代入する
        if self.delegate.tag != -1
        {
            let HW:HomeWork = HomeWork()
            HW.Tag = self.delegate.tag
            HW.Name = self.taskN
            //HW.Ntime = self.deadline
            HW.isFinished = false
            
            try! realm.write {
                realm.add(HW, update: true)
            }
        }

        
        // 背景色
        self.view.backgroundColor = self.delegate.BGColor
        
        // TableViewの生成(諸々の高さをずらして表示).
        
        if taskExist == false{
            myTableView = UITableView(frame: CGRect(x: 0, y: barHeight + 152, width: displayWidth, height: displayHeight))
        }else{
            myTableView = UITableView(frame: CGRect(x: 0, y: barHeight + 202, width: displayWidth, height: displayHeight))
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.imageView?.image = UIImage(named: "hito2.jpg")!
        
        // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceを自身に設定する.
        myTableView.dataSource = self
        
        // Delegateを自身に設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)

    }
    
    
    
    //Cellが選択された際に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if finished{
            self.finished = false
        }else{
            self.finished = true
        }
        self.createSection()
        print("Num: \(indexPath.row)")
        print("Value: \(taskName[indexPath.row])")
    }
    
    
    //Cellの総数を返す.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("CellCount: \(taskName.count)")
        return taskName.count
    }
    
    
    //Cellに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //課題が終わったかどうかを表すチェックボックスの画像を生成
        let boxIcon: UIImage = UIImage(named: "box.jpg")!
        let checkIcon: UIImage = UIImage(named: "check.jpg")!
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        //生成したセルの画像部分に終了済みかどうかに合わせて代入
        if !self.finished{
            cell.imageView?.image = boxIcon
        }else{
            cell.imageView?.image = checkIcon
        }
        // 再利用するCellを取得する.
        //let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(taskName[indexPath.row])"
        cell.detailTextLabel?.text = "10/9   9:10" // 期限
        
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
