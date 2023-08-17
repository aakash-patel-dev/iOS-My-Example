//
//  CardModel+CoreDataProperties.swift
//  ConstraintPractices
//
//  Created by P21_0105 on 17/02/22.
//
//

import Foundation
import CoreData


extension CardModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardModel> {
        return NSFetchRequest<CardModel>(entityName: "CardModel")
    }

    @NSManaged public var amount: String?
    @NSManaged public var cName: String?
    @NSManaged public var cNumber: String?
    @NSManaged public var cvvNumber: String?

}

extension CardModel : Identifiable {

}
