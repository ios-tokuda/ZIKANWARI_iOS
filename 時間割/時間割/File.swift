import UIKit

class File: UIViewController, UIPickerViewDelegate{
    
    //@IBOutlet weak var textField: UITextField!
    var textField: UITextField!

    let pickerView = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        let tWidth: CGFloat = 200
        let tHeight: CGFloat = 30
        let posX: CGFloat = (self.view.bounds.width - tWidth)/2
        let posY: CGFloat = (self.view.bounds.height - tHeight)/2
        textField = UITextField(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
        self.view.addSubview(textField)
        textField.borderStyle = .roundedRect
        
        
        
        pickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: pickerView.bounds.size.height)
        // 値が変わった際のイベントを登録する.
        pickerView.addTarget(self, action: #selector(self.onDidChangeDate(sender:)), for: .valueChanged)
        
        let vi = UIView(frame: pickerView.bounds)
        vi.backgroundColor = UIColor.white
        vi.addSubview(pickerView)
        
        textField.inputView = vi
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.gray
        let doneButton   = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.cancelPressed))
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
    }
    
    // Done
    func donePressed() {
        view.endEditing(true)
    }
    
    // Cancel
    func cancelPressed() {
        textField.text = ""
        view.endEditing(true)
    }
    
    internal func onDidChangeDate(sender: UIDatePicker){
        
        // フォーマットを生成.
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        // 日付をフォーマットに則って取得.
        let mySelectedDate: String = myDateFormatter.string(from: sender.date)
        self.textField.text = mySelectedDate as String
    }
    
 
}
