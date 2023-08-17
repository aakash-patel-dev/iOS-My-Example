//
//  DataBaseHelper.swift
//  ConstraintPractices
//
//  Created by P21_0105 on 17/02/22.
//

import Foundation
import CoreData
import UIKit


class DataBaseHelper {
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    static var shareInstance = DataBaseHelper()
    func save(obj : [String : String]){
        let data = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context!)
    }
}
