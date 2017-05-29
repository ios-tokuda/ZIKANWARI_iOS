//
//  Setting.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/22.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import Foundation
import UIKit

class Setting: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定されたタイトルを代入するとナビゲーションコントローラに反映される。
        self.title = "設定"
        // 背景色
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ボタンが押された時の処理。
    internal func onClickMyButton(sender: UIButton) {
        print("onClickMyButton:");
        print("sender.tag: \(sender.tag)")
        
        
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = One_VC()
        // Viewの移動する.
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
    }
    
}

