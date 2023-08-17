//
//  RegisterViewController.swift
//  constraintExample
//
//  Created by P21_0105 on 28/01/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func signUp(_ sender: Any) {
        if(name.text?.count == 0){
            alertForValidate(text: "Please enter your name")
        }
        else if(email.text?.count == 0){
            alertForValidate(text: "Please enter your email")
        }
        else if(!isValidEmail(testStr: email.text)){
            alertForValidate(text: "Please enter valid email")
        }
        else if(mobile.text?.count == 0){
            alertForValidate(text: "Please enter your mobile number")
        }
        else if(password.text?.count == 0){
            alertForValidate(text: "Please enter your password")
        }
     
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
    
}
