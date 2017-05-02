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
    static var Horizontal = 5   //時間割縦数
    static var Vertical = 5     //時間割横数
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 設定されたタイトルを代入するとナビゲーションコントローラに反映される。
        self.title = "時間割"
        
        // 背景は白色
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

