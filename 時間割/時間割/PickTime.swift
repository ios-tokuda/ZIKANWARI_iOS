//
//  PickTime.swift
//  時間割
//
//  Created by 沼田悠貴 on 2017/06/08.
//  Copyright © 2017年 浅見朋. All rights reserved.
//


import UIKit

class PickTime: UIViewController, UIPickerViewDelegate {
    
    private var myTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // DatePickerを生成する.
        let myDatePicker: UIDatePicker = UIDatePicker()
        
        // datePickerを設定（デフォルトでは位置は画面上部）する.
        myDatePicker.frame = CGRect(x:0, y:50, width:self.view.frame.width, height:200)
        myDatePicker.timeZone = NSTimeZone.local
        myDatePicker.backgroundColor = UIColor.white
        myDatePicker.layer.cornerRadius = 5.0
        myDatePicker.layer.shadowOpacity = 0.5
        
        // 値が変わった際のイベントを登録する.
        myDatePicker.addTarget(self, action: #selector(PickTime.onDidChangeDate(sender:)), for: .valueChanged)
        
        // DataPickerをViewに追加する.
        self.view.addSubview(myDatePicker)
        
        // UITextFieldを作成する.
        myTextField = UITextField(frame: CGRect(x:0,y:0,width:200,height:30))
        myTextField.text = ""
        myTextField.borderStyle = UITextBorderStyle.roundedRect
        myTextField.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height - 100);
        
        // UITextFieldをViewに追加する.
        self.view.addSubview(myTextField)
        
        print("ピッカー")
    }
    
    /*
     DatePickerが選ばれた際に呼ばれる.
     */
    internal func onDidChangeDate(sender: UIDatePicker){
        
        // フォーマットを生成.
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        // 日付をフォーマットに則って取得.
        let mySelectedDate: NSString = myDateFormatter.string(from: sender.date) as NSString
        myTextField.text = mySelectedDate as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
