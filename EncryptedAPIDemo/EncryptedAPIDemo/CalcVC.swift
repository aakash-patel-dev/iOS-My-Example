//
//  CalcVC.swift
//  EncryptedAPIDemo
//
//  Created by P21-0054 on 10/05/22.
//

import UIKit
import FirebaseDynamicLinks
import CoreData

class CalcVC: UIViewController {
            
    @IBOutlet weak var tblView: UITableView!
    
    var student: [Model]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TestVC") as! TestVC
        nextVC.completionHandler = {
            let context = delegate.persistentContainer.viewContext
            
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
                let result = try context.fetch(request)
                for data in result {
                    let studentData = (data as AnyObject)
                    print("Name \(studentData.value(forKey: "name") ?? "")")
                    print("City \(studentData.value(forKey: "city") ?? "")")
                    
                }
            } catch {
                print("Error occured")
            }
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}


class StudentModel: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var city: String
}
