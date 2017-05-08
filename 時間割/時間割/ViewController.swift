//
//  ViewController.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/01.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    public let DAYS :[String] = ["月", "火", "水", "木", "金", "土"]
    
    
    
    //設定で変更可能にしたい。
    var Len_H:Int = 5  //時間割縦数
    var Len_V:Int = 5     //時間割横数
    let haba:CGFloat = 20  //端のラベルの幅
    let edge_NC:CGFloat = 64 //ナビゲーションコントローラの下端の座標 全端末共通
    let space:CGFloat = 1   //ラベル間の幅

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定を読み込ませたい
        self.Len_V = 5
        self.Len_H = 5
        
        // 設定されたタイトルを代入するとナビゲーションコントローラに反映される。
        self.title = "時間割"
        //端のラベルを表示
        self.drawEdgeLabels();
        //時間割のボタンを表示
        self.drawTTButtons()
        // 背景は白色
        self.view.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
            
            // UILabelの背景を白色に.
            label.backgroundColor = UIColor.white
            
            //labelの枠線
            label.layer.borderColor = UIColor.gray.cgColor
            label.layer.borderWidth = 1.0;
            
            // 文字の色を白に定義.
            label.textColor = UIColor.black
            
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
        
            // UILabelの背景を白色に.
            label.backgroundColor = UIColor.white
        
            //labelの枠線
            label.layer.borderColor = UIColor.gray.cgColor
            label.layer.borderWidth = 1.0;
        
            // 文字の色を白に定義.
            label.textColor = UIColor.black
        
            // UILabelに文字を代入.
            label.text = self.DAYS[i]
        
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
                //let label: UILabel = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
                
                ttButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
                
                
                // UILabelの背景を白色に.
                ttButton.backgroundColor = UIColor.white
                
                //labelの枠線
                ttButton.layer.borderColor = UIColor.gray.cgColor
                ttButton.layer.borderWidth = 1.0;
                
                // タイトルを設定する(通常時).
                ttButton.setTitle("( ^ω^)", for: .normal)
                ttButton.setTitleColor(UIColor.black, for: .normal)
                
                // タイトルを設定する(ハイライト時).
                ttButton.setTitle("(　ﾟДﾟ)", for: .highlighted)
                ttButton.setTitleColor(UIColor.black, for: .highlighted)
                
                // イベントを追加する
                ttButton.addTarget(self, action: #selector(ViewController.onClickMyButton(sender:)), for: .touchUpInside)

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
    
    //ボタンが押された時の処理。
    internal func onClickMyButton(sender: UIButton) {
        print("onClickMyButton:");
        print("sender.tag: \(sender.tag)")
    }

}

