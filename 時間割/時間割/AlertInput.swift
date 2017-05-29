//
//  AlertInput.swift
//  時間割
//
//  Created by 沼田悠貴 on 2017/05/28.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import UIKit

class AlertInput: UIAlertController
{
    var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func showAlert(vc:One_VC){
        
        let alertCtr = UIAlertController(title: "課題",
                                         message: "入力してください",
                                         preferredStyle: .alert)
        
        // テキストフィールドを追加
        alertCtr.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "テキスト"
        })
        
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "追加",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("追加")
                                                        // 追加を押した時入力されていたテキストを表示
                                                        if let textFields = alertCtr.textFields {
                                                            
                                                            // アラートに含まれるすべてのテキストフィールドを調べる
                                                            for textField in textFields {
                                                                print(textField.text!)
                                                            }
                                                        }
                                                        
        })
        
        let timeAction:UIAlertAction = UIAlertAction(title: "日時",
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            print("日時")
        })
        
        let destructiveAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                            style: UIAlertActionStyle.destructive,
                                                            handler:{
                                                                (action:UIAlertAction!) -> Void in
                                                                print("Cancel")
        })
        
        
        alertCtr.addAction(cancelAction)
        alertCtr.addAction(timeAction)
        alertCtr.addAction(destructiveAction)
        
        vc.present(alertCtr, animated: true, completion: nil)
    }
}
