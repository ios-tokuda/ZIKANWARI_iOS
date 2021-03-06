//
//  AppDelegate.swift
//  時間割
//
//  Created by 浅見朋 on 2017/05/01.
//  Copyright © 2017年 浅見朋. All rights reserved.
//

import UIKit
//import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var tag:Int = -1
    
    //selectを呼び出したときの課題
    var ID:Int = -1
    
    //Alertinputから値を渡すための変数
    var taskName:String!
    var timeName:String!
    var teachName:String!
    var className:String!
    var classRoomName:String!
    
    //背景色
    let BGColor:UIColor = UIColor(red:0.47, green:0.81, blue:0.95, alpha:1)
    //通常ラベルカラー
    let LColorN:UIColor = UIColor(red:0.37, green:0.67, blue:0.83, alpha:1)
    //現在曜日のラベルカラー
    let LColorPU:UIColor = UIColor(red:0.99, green:0.75, blue:0.18, alpha:1)
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {//[NSObject: AnyObject]?) -> Bool {
        
        //起動時のviewcontroller
        // ViewControllerを生成する.
        let FirstViewController: UIViewController = Week_VC()
        
        // myFirstViewControllerをrootviewに設定し、Navication Controllerを生成する.
        let NavigationController: UINavigationController = UINavigationController(rootViewController: FirstViewController)
        
        
        // rootViewControllerにNavigationControllerを設定する.
        self.window?.rootViewController = NavigationController
        
        // NavigationControllerを表示する.
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

