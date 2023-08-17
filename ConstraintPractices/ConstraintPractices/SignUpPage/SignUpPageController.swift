//
//  SignUpController.swift
//  ConstraintPractices
//
//  Created by P21_0105 on 17/02/22.
//

import UIKit
import UnderLineTextField
import RAGTextField
class SignUpPageController: UIViewController, UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var itemPicker : UIPickerView! = UIPickerView()
    var bloodPicker : UIPickerView! = UIPickerView()
    var datePicker : UIDatePicker! = UIDatePicker()

    @IBOutlet weak var usrText: UnderLineTextField!
    var gender = ["MALE","FEMALE"]
    var bloodGroup = ["A+","B+","B-","O+","O-","A-"]
//    @IBOutlet weak var usrText: RAGTextField!
//    @IBOutlet weak var usrName: UITextField!
    @IBOutlet weak var usrPass: UnderLineTextField!
    @IBOutlet weak var usrPhone: UnderLineTextField!
     @IBOutlet weak var userDate: UnderLineTextField!
   
    @IBOutlet weak var userGen: UnderLineTextField!
    @IBOutlet weak var usrBlood: UnderLineTextField!
    @IBOutlet weak var usrEmail: UnderLineTextField!
    //    @IBOutlet weak var usrGen: DropDown!
//
//    @IBOutlet weak var usrBlood: DropDown!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotifications()
        userGen!.delegate = self
        usrBlood.delegate = self
        itemPicker.delegate = self
        itemPicker.dataSource = self
        bloodPicker.delegate = self
        bloodPicker.dataSource = self
        usrPhone.delegate = self
        usrPhone.keyboardType  = .numberPad
        
        self.userGen.inputView = itemPicker
        self.usrBlood.inputView = bloodPicker
        self.userDate.inputView = datePicker
        
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
//        datePicker.preferredDatePickerStyle = .inline
//        datePicker.datePickerMode = .date
//        datePicker.addTarget(self, action: #selector(SignUpPageController.datePickerValueChanged(_:)), for: .valueChanged)
// 
//        datePicker.maximumDate = Date.now.addingTimeInterval(-86400)
        userGen.text = gender.first
        usrBlood.text = bloodGroup.first
        
        usrPhone.addTarget(self, action: #selector(self.textFieldFilter(_:)), for: .editingChanged)
    }
    @objc private func textFieldFilter(_ textField: UITextField) {
      if let text = textField.text, let intText = Int(text) {
        textField.text = "\(intText)"
      } else {
        textField.text = ""
      }
    }
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        userDate.text = Calendar.current.date(byAdding: .year, value: -18, to: Date())?.string(format:"MM/dd/yyyy" )
             let dateFormatter: DateFormatter = DateFormatter()
            
             dateFormatter.dateFormat = "MM/dd/yyyy"
            
             let selectedDate: String = dateFormatter.string(from: sender.date)
     
            userDate.text = selectedDate
        
        
        userDate.resignFirstResponder()
         }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == itemPicker ? gender.count : bloodGroup.count
    }
    
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return pickerView == itemPicker ? gender[row] : bloodGroup[row]
       }
       
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
       {
//           userGen.text = gender.first
//           usrBlood.text = bloodGroup.first
           var titleRow = ""
                if pickerView == itemPicker {
                       titleRow = gender[row]
                    userGen.text = titleRow
                       
                  } else if pickerView == bloodPicker {
                       titleRow = bloodGroup[row]
                      usrBlood.text = titleRow
                  }
           
           self.view.endEditing(true)

        }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
       
        let invalidCharacters =
            CharacterSet(charactersIn: "0123456789").inverted
          return (string.rangeOfCharacter(from: invalidCharacters) == nil)

        
    }
    func alertForValidate(text : String?){
        var title = ""
        text == "Registration successfully" ? ( title = "Great..") : (title = "Oops...")
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            switch action.style {
    
            case .cancel:
                print("")
            case .destructive:
                print("")
            case .default:
                print("helloooooo")
            @unknown default:
                print("")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func send(_ sender: Any) {
        if(usrText.text?.count == 0){
            alertForValidate(text: "Please enter your name")
        }
        else if(usrPass.text?.count == 0){
            alertForValidate(text: "Please enter your password")
        }
        else if(usrPhone.text?.count == 0){
            alertForValidate(text: "Please enter your phone")
        }
        else if(userGen.text?.count == 0){
            alertForValidate(text: "Please select your gender")
        }
        else if(usrBlood.text?.count == 0){
            alertForValidate(text: "Please select your blood group")
        }
        else if(userDate.text?.count == 0){
            alertForValidate(text: "Please select your birth date")
        }
        else if(!isValidEmail(testStr: usrEmail.text)){
            alertForValidate(text: "Please enter valid Email")
        }
//        else if(userDate.text == Date().string(format: "MM/dd/yyyy") ){
//            alertForValidate(text: "Please select valid date")
//             
//        }
         
        else{
            alertForValidate(text: "Registration successfully")
        }
        
    }
    
    func isValidEmail(testStr:String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }
    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
