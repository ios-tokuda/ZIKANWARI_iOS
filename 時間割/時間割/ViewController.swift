//
//  ViewController.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/01.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //設定で変更可能にしたい。
    var Len_H:Int = 5   //時間割縦数
    var Len_V:Int = 5     //時間割横数
    let haba:CGFloat = 20  //端のラベルの幅
    let edge_NC:CGFloat = 64 //ナビゲーションコントローラの下端の座標
    let space:CGFloat = 1   //ラベル間の幅

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定を読み込ませたい
        // 設定されたタイトルを代入するとナビゲーションコントローラに反映される。
        self.title = "時間割"
        
        self.drawLabels();
        // 背景は白色
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func drawLabels(){
        for i in 0..<Len_H{
            // ボタンのサイズを定義.
            let bWidth: CGFloat = self.haba - self.space
            let bHeight: CGFloat = CGFloat(CGFloat(view.bounds.height - self.haba - self.edge_NC)/CGFloat(Len_H)) - self.space
            
            // 配置する座標を定義(画面の中心).
            let posX: CGFloat = 0
            let posY: CGFloat = self.edge_NC + self.haba + CGFloat(i)*(bHeight + self.space)
            
            // Labelを作成.
            let label: UILabel = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
            
            // UILabelの背景を白色に.
            label.backgroundColor = UIColor.white
            
            //labelの枠線
            label.layer.borderColor = UIColor.black.cgColor
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
        for i in 0..<Len_V{
            // ボタンのサイズを定義.
            let bWidth: CGFloat = CGFloat(CGFloat(view.bounds.width - self.haba)/CGFloat(Len_H)) - self.space
            let bHeight: CGFloat = self.haba - self.space
        
            // 配置する座標を定義(画面の中心).
            let posX: CGFloat = self.haba + CGFloat(i)*(bWidth + self.space)
            let posY: CGFloat = self.edge_NC
        
            // Labelを作成.
            let label: UILabel = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
        
            // UILabelの背景を白色に.
            label.backgroundColor = UIColor.white
        
            //labelの枠線
            label.layer.borderColor = UIColor.black.cgColor
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
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

