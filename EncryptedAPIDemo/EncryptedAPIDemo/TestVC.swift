//
//  TestVC.swift
//  EncryptedAPIDemo
//
//  Created by P21-0054 on 10/05/22.
//

import UIKit
import CoreData

let stude = [StudentModel]()

class TestVC: UIViewController {
        
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
    var completionHandler : (()->Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)
        let newStudent = NSManagedObject(entity: entity!, insertInto: context)
        newStudent.setValue(txtName.text, forKey: "name")
        newStudent.setValue(txtCity.text, forKey: "city")
        
        do {
            try context.save()
            self.completionHandler()
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Can't save")
        }
    }
}

