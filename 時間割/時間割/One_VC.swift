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
    
    
    //Alertで入力され、Realmに保存する変数
    var taskN = ""              //課題名
    var timeN: Date? = nil      //提出期限
    var timeNString = ""        //提出期限((表示用)
    
    // デフォルトRealmを取得
    let realm:Realm = try! Realm()
    
    //Realmに保存された課題を入れる変数
    var WorkList:Results<HomeWork>!
    

    //テーブルをいじるとテーブルが大幅にずれるのを防ぐ変数
    var taskExist = false
    
    
    // Status Barの高さを取得をする.
    var barHeight: CGFloat!
    
    // Viewの高さと幅を取得する.
    var displayWidth: CGFloat!
    var displayHeight: CGFloat!
    
    //deligateにおいてあるメンバにはここからアクセス
    //VCをまたいで値を渡したい時などに用いる
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    let edge_NC:CGFloat = 64 //ナビゲーションコントローラの下端の座標 全端末共通
    
    var tag:Int = -1
    
    //ナビゲーションボタンの生成
    private var myRightButton: UIBarButtonItem!
    
    //ピッカーを配置
    let pickerView = UIDatePicker()
    var vi:UIView!
    var textField: UITextField!
    var toolBar:UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Week_VCでタップされたコマのタグを取得
        self.tag = self.delegate.tag
                print("sender.tag: \(self.tag)")
        
        
        // Status Barの高さを取得をする.
        barHeight = UIApplication.shared.statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        displayWidth = self.view.frame.width
        displayHeight = self.view.frame.height

        
        //右ボタンを作成する
        myRightButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(One_VC.onClickMyButton(sender:)))
        
        //ナビゲーションバーの右に設置する
        self.navigationItem.rightBarButtonItem = myRightButton
        
        //見た目作成メソッド
        self.createSection()
        self.createDisplay()
        
        
        self.picktime()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recrp0eated.
    }
    
    
    func picktime()
    {
        
        pickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: pickerView.bounds.size.height)
        // 値が変わった際のイベントを登録する.
        pickerView.addTarget(self, action: #selector(self.onDidChangeDate(sender:)), for: .valueChanged)
        
        vi = UIView(frame: pickerView.bounds)
        vi.backgroundColor = UIColor.white
        vi.addSubview(pickerView)
        
        //textField.inputView = vi
        
        toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.gray
        //let doneButton   = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.donePressed))
        //let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.cancelPressed))
        //let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        //toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        //textField.inputAccessoryView = toolBar
        
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
        Appearance()    //枠作成
        Icon()          //講師名、教室、授業時間がひと目で分かるアイコンの配置
        cLabel()        //指定されたタグの講義の情報をアイコンの横に表示
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
        
        //帯を装飾するだけの線
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
        //選択したコマのタグをもつTimeTableをすべて呼び出す
        let WorkList:Results<HomeWork> = self.realm.objects(HomeWork.self).filter("Tag == " + (String)(self.tag))
        let count = WorkList.count      //現在の課題数
        
        //タグが初期値でなければRealmに値を代入する
        if self.tag != -1 && self.taskN != ""
        {
            let HW:HomeWork = HomeWork()
            HW.Id = count + 1               //現在の課題数+1
            HW.Tag = self.tag               //コマのタグ
            HW.Name = self.taskN            //課題名
            //HW.Ntime = self.deadline
            HW.isFinished = false           //初期値は偽
            HW.NTime = self.timeN           //提出期限
            HW.NTimeString = self.timeNString   //提出期限(表示用)
            
            //Alertから入力される値の初期化
            self.taskN = ""                 //セルをタップした際に課題がコピーされるのを防ぐ
            self.timeNString = ""
            
            //追加
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
        //コマの課題を追加
        let WorkList:Results<HomeWork> = self.realm.objects(HomeWork.self).filter("Tag == " + (String)(self.tag))
        //選択されたセル
        let currentTask = WorkList[indexPath.row]
        
        try! realm.write{
            //タップされたセルの課題が終わったかどうか
            if currentTask.isFinished{
                currentTask.isFinished = false
            }else{
                currentTask.isFinished = true
            }
        }
        //タップされた = 課題が存在する
        self.taskExist = true
        //更新
        self.createSection()
        
        //標準出力
        print("Num: \(indexPath.row)")
        print("Value: \(currentTask.Name)")
    }
    
    
    //選択されたコマのタグの課題数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let WorkList:Results<HomeWork> = self.realm.objects(HomeWork.self).filter("Tag == " + (String)(self.tag))
        return WorkList.count
    }
    
    
    //Cellに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //選択されたコマの課題
        let WorkList:Results<HomeWork> = self.realm.objects(HomeWork.self).filter("Tag == " + (String)(self.tag))
        //現在のセル
        let currentTask = WorkList[indexPath.row]
        
        //課題が終わったかどうかを表すチェックボックスの画像を生成
        let boxIcon: UIImage = UIImage(named: "box.jpg")!
        let checkIcon: UIImage = UIImage(named: "check.jpg")!
        
        //生成したセルの画像部分に終了済みかどうかに合わせて代入
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        if !currentTask.isFinished{
            cell.imageView?.image = boxIcon
        }else{
            cell.imageView?.image = checkIcon
        }
        
        // 再利用するCellを取得する.
        //let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(currentTask.Name)"
        if currentTask.NTime != nil{
            cell.detailTextLabel?.text = currentTask.NTimeString
        }
        
        return cell
    }
    
    
    ///////////////////////////////////////
    //ピッカー関連
    //Pickerの Doneが押された時
    func donePressed() {
        view.endEditing(true)
    }
    
    //pickerの Cancelが押された時
    func cancelPressed() {
        textField.text = ""
        view.endEditing(true)
    }
    //pickerが操作された際に自動的にその値を取得した上で実行されます
    internal func onDidChangeDate(sender: UIDatePicker){
        
        
        
        // フォーマットを生成.
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.locale = Locale(identifier: "ja_JP_POSIX")
        myDateFormatter.dateFormat = "MM/dd hh:mm"
        
        // 日付をフォーマットに則って取得.
        let mySelectedDate: String = myDateFormatter.string(from: sender.date)
        timeN = sender.date
        timeNString = myDateFormatter.string(from: sender.date)
        self.textField.text = mySelectedDate as String
    }
    
    
    //////////////////
    //ピッカーの問題となる場所
    //////////////////
    func sendPickTime()
    {
        print("ぬるま湯なんかに浸かってんじゃねぇよお前！！")
        pickerView.becomeFirstResponder()
        toolBar.becomeFirstResponder()
        vi.becomeFirstResponder()
        /*
        // 遷移するViewを定義する.
        let picktime: UIViewController = PickTime()
        // Viewの移動する.
        self.navigationController?.pushViewController(picktime, animated: true)
        
*/
    }
    
}
