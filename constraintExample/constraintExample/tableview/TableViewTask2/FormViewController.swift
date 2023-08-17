//
//  FormViewController.swift
//  constraintExample
//
//  Created by P21_0105 on 24/01/22.
//

import UIKit

class FormViewController: UIViewController {
    var strArray : [String] = []

    @IBOutlet weak var inputText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addData(_ sender: Any) {
        
        strArray.append(inputText.text!)
       
            inputText.text = nil
      
        
    }
    
    @IBAction func goToList(_ sender: Any) {
        let viewController =     storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
      
        viewController.strArray = strArray
        navigationController?.pushViewController(viewController, animated: true)
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
