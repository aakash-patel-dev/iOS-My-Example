//
//  Demo1.swift
//  EncryptedAPIDemo
//
//  Created by P21-0054 on 07/06/22.
//

import UIKit

class Demo1: UIViewController {

    var model: Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnAction(_ sender: Any) {
        print(Model.shared.toDictionary())
    }
}
