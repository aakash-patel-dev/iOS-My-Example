//
//  NameViewController.swift
//  constraintExample
//
//  Created by P21_0105 on 21/01/22.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet var name: UILabel!
    var str :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = str
        // Do any additional setup after loading the view.
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
