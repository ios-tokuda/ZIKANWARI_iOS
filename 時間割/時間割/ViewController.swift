import UIKit

class ViewController: UIViewController {
    var tableView: UITableView!
    var myButton: UIButton!
    var youbi_flag=0
    // セクションの情報を定義
    enum SectionMember: Int {
        case help, about,time, delete,last
        var title: String? {
            let titles = ["曜日数", "時限数","通知設定","その他の設定"]
            return titles[self.rawValue]
        }
        var count: Int {
            let members = [AccountSectionMember.last.rawValue, SettingSectionMember.last.rawValue, timeSectionMember.last.rawValue,deleteSectionMember.last.rawValue,0]
            return members[self.rawValue]
        }
    }
    // セクションのメンバー情報を定義
    enum AccountSectionMember: Int {
        case account, timeline, last
        var title: String? {
            let titles = ["土曜日の追加", "日曜日の追加"]
            return titles[self.rawValue]
        }
    }
    enum SettingSectionMember: Int {
        case sound, data, last
        var title: String? {
            let titles = ["五限目の追加", "六限目の追加"]
            return titles[self.rawValue]
        }
    }
    enum timeSectionMember: Int {
        case kigen,  last
        var title: String? {
            let titles = ["通知日の変更"]
            return titles[self.rawValue]
        }
    }
    enum deleteSectionMember: Int {
        case kigen,  last
        var title: String? {
            let titles = ["リセット"]
            return titles[self.rawValue]
        }
    }
    // テーブルの情報をさくっととれるように
    struct TableInfo {
        var section: SectionMember
        var row: Int = 0
        
        init(inSection section: Int) {
            self.section = SectionMember(rawValue: section)!
        }
        init(indexPath: IndexPath) {
            self.init(inSection: indexPath.section)
            self.row = indexPath.row
        }
        
        func rowMemberTitle() -> String? {
            switch self.section {
            case .help:
                return AccountSectionMember(rawValue: row)?.title
            case .about:
                return SettingSectionMember(rawValue: row)?.title
            case .time:
                return timeSectionMember(rawValue: row)?.title
            case .delete:
                return deleteSectionMember(rawValue: row)?.title

            default:
                return nil
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tableView = UITableView(frame: self.view.frame, style: .grouped)
        
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .singleLine
        self.view.addSubview(tableView)
        // Swicthを作成する
        let mySwicth: UISwitch = UISwitch()
        mySwicth.layer.position = CGPoint(x: self.view.frame.width/1.2+10, y: self.view.frame.height/2-250 + 64)
        //mySwicth.layer.
        // SwitchをOnに設定
        mySwicth.isOn = false
        // SwitchのOn/Off切り替わりの際に、呼ばれるイベントを設定する.
        mySwicth.addTarget(self, action: #selector(ViewController.onClickMySwicth(sender:)), for: UIControlEvents.valueChanged)
        // SwitchをViewに追加
        self.view.addSubview(mySwicth)
        // Swicthを作成する
        let mySwicth2: UISwitch = UISwitch()
        mySwicth2.layer.position = CGPoint(x: self.view.frame.width/1.2+10, y: self.view.frame.height*0.19+10 + 64)
        // SwitchをOnに設定
        mySwicth2.isOn = false
        // SwitchのOn/Off切り替わりの際に、呼ばれるイベントを設定する.
        mySwicth2.addTarget(self, action: #selector(ViewController.onClickMySwicth(sender:)), for: UIControlEvents.valueChanged)
        // SwitchをViewに追加
        self.view.addSubview(mySwicth2)

        let mySwicth3: UISwitch = UISwitch()
        mySwicth3.layer.position = CGPoint(x: self.view.frame.width/1.2+10, y: self.view.frame.height - 410 + 64)
        // SwitchをOnに設定
        mySwicth3.isOn = false
        // SwitchのOn/Off切り替わりの際に、呼ばれるイベントを設定する.
        mySwicth3.addTarget(self, action: #selector(ViewController.onClickMySwicth(sender:)), for: UIControlEvents.valueChanged)
        // SwitchをViewに追加
        self.view.addSubview(mySwicth3)
        
        let mySwicth4: UISwitch = UISwitch()
        mySwicth4.layer.position = CGPoint(x: self.view.frame.width/1.2+10, y: self.view.frame.height - 355 + 64)
        // SwitchをOnに設定
        mySwicth4.isOn = false
        // SwitchのOn/Off切り替わりの際に、呼ばれるイベントを設定する.
        mySwicth4.addTarget(self, action: #selector(ViewController.onClickMySwicth(sender:)), for: UIControlEvents.valueChanged)
        // SwitchをViewに追加
        self.view.addSubview(mySwicth4)
        
        /*// ボタンを生成.
        myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 50))
        myButton.backgroundColor = UIColor.white
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.frame.width-40, y: self.view.frame.height-30)
        myButton.setTitle("土曜日", for: .normal)
        myButton.setTitleColor(UIColor.black, for: .normal)
        myButton.layer.borderWidth = 1.0
        myButton.layer.borderColor = UIColor.black.cgColor
        myButton.addTarget(self, action: #selector(ViewController.onClickMyButton(sender:)), for: .touchUpInside)
        self.view.addSubview(myButton)*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClickMySwicth(sender: UISwitch){
        
        if sender.isOn {
            //            myLabel.text = "On"
            //            myLabel.backgroundColor = UIColor.red
        } else {
            //            myLabel.text = "Off"
            //            myLabel.backgroundColor = UIColor.blue
        }
    }
    
    func onClickMyButton(sender: UIButton) {
        
        
        if (youbi_flag==0) {
            
            myButton.backgroundColor = UIColor.cyan
            youbi_flag=1;
        }
        else {
            
            
            myButton.backgroundColor = UIColor.white
            youbi_flag=0;
        }
    }

}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionMember.last.rawValue
    }
    //treeviewの縦の位置
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableInfo(inSection: section).section.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TableInfo(inSection: section).section.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath as IndexPath)
        let tableInfo = TableInfo(indexPath: indexPath)
        // タイトルの取得
        cell.textLabel?.text = tableInfo.rowMemberTitle()!
        // 個別の処理はこんな感じ
//        if tableInfo.section == .help && tableInfo.row == AccountSectionMember.account.rawValue {
//            cell.accessoryType = .disclosureIndicator
//        }
        return cell
    }
}
