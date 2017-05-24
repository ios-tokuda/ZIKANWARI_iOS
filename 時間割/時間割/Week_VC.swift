//
//  ViewController.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/01.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import UIKit

class Week_VC: UIViewController, UITextFieldDelegate {
    
    public let WEEK_DAYS :[String] = ["日", "月", "火", "水", "木", "金", "土"]
    
    private var myTextField: UITextField!
    
    //設定で変更可能にしたい。
    var Len_H:Int = 5  //時間割縦数
    var Len_V:Int = 5     //時間割横数
    let haba:CGFloat = 40  //端のラベルの幅
    let edge_NC:CGFloat = 64 //ナビゲーションコントローラの下端の座標 全端末共通
    let space:CGFloat = 1   //ラベル間の隙間の幅
    var nowDay:Int = 0  //今の曜日
    
    


    
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
        
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
        self.view.backgroundColor = UIColor(red:0.47, green:0.81, blue:0.95, alpha:1)
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func Input()
    {
        // UITextFieldの配置するx,yと幅と高さを設定.
        let tWidth: CGFloat = 200
        let tHeight: CGFloat = 30
        let posX: CGFloat = (self.view.bounds.width - tWidth)/2
        let posY: CGFloat = (self.view.bounds.height - tHeight)/2
        
        // UITextFieldを作成する.
        myTextField = UITextField(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
        
        // 表示する文字を代入する.
        myTextField.text = ""
        
        // Delegateを自身に設定する
        myTextField.delegate = self
        
        // 枠を表示する.
        myTextField.borderStyle = .roundedRect
        
        // クリアボタンを追加.
        myTextField.clearButtonMode = .whileEditing
        
        // Viewに追加する
        self.view.addSubview(myTextField)

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
            label.backgroundColor = UIColor(red:0.37, green:0.67, blue:0.83, alpha:1)
            
            
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
                label.backgroundColor = UIColor(red:0.99, green:0.75, blue:0.18, alpha:1)
            }else{
                label.backgroundColor = UIColor(red:0.37, green:0.67, blue:0.83, alpha:1)
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
                
                // タイトルを設定する(通常時).
                ttButton.setTitle("", for: .normal)
                ttButton.setTitleColor(UIColor.black, for: .normal)
                
                // タイトルを設定する(ハイライト時).
                ttButton.setTitle("", for: .highlighted)
                ttButton.setTitleColor(UIColor.black, for: .highlighted)
                
                // イベントを追加する
                ttButton.addTarget(self, action: #selector(self.onClickMyButton(sender:)), for: .touchUpInside)
                
                // ボタンにタグをつける.
                ttButton.tag = j + 5 * i
                
                
                // ViewにBottunを追加.
                self.view.addSubview(ttButton)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //UITextFieldが編集された直前に呼ばれる
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
    }
    
    
     //UITextFieldが編集された直後に呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text!)")
    }
    
    
    
    //改行ボタンが押された際に呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        
        // 改行ボタンが押されたらKeyboardを閉じる処理.
        textField.resignFirstResponder()
        
        return true
    }

    
    //ボタンが押された時の処理。
    internal func onClickMyButton(sender: UIButton) {
        print("onClickMyButton:");
        print("sender.tag: \(sender.tag)")
        
        self.Input()
        
        self.delegate.tag = sender.tag
        // 遷移するViewを定義する.
        //let mySecondViewController: UIViewController = One_VC()
        // Viewの移動する.
        //self.navigationController?.pushViewController(mySecondViewController, animated: true)
    }
    
}

