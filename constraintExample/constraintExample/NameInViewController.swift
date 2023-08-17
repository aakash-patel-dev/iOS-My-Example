//
//  NameInViewController.swift
//  constraintExample
//
//  Created by P21_0105 on 24/01/22.
//

import UIKit

class NameInViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var inputName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        inputName.delegate = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendName(_ sender: Any) {
        let str = inputName.text!
        let viewController =     storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
      
        viewController.str = "Welcome \(str)"
        print(str)
        navigationController?.pushViewController(viewController, animated: true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.text)
    }
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        true
//    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print(textField.text)
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
      textField.resignFirstResponder()

        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
