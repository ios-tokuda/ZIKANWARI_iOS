//
//   Launch_VC.swift
//  時間割
//
//  Created by 浅見朋 on 2017/07/12.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import Foundation
import UIKit

class Launch_VC: UIViewController {
    
    var imageView:UIImageView!
    var scale:CGFloat = 1.0
    var width:CGFloat = 0
    var height:CGFloat = 0
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    var timer: Timer!
    var cnt : Float = 0
    var flag: Int=0
    var count: Double=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Screen Size の取得
        screenWidth = self.view.bounds.width
        screenHeight = self.view.bounds.height
        
        // UIImage インスタンスの生成
        let image = UIImage(named:"hei.jpg")!
        
        // 画像の幅・高さの取得
        width = image.size.width
        height = image.size.height
        
        // UIImageView インスタンス生成
        imageView = UIImageView(image:image)
        
        // 画像サイズをスクリーン幅に合わせる
        scale = 0.2
        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
        
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        
        // 画像の中心をスクリーンの中心位置に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        
        // view に ImageView を追加する
        self.view.addSubview(imageView)
        
    }
    
    //時間の処理
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    func update(tm: Timer) {
        
        if(width*scale < screenWidth-100&&count>=1){
            scale += 0.05
        }
        count=count+0.03
        if(width*scale >= screenWidth-100){
            //画面推移
            //self.view.backgroundColor = UIColor.cyan
        }
        
        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
        imageView.frame = rect;
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        self.view.addSubview(imageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
