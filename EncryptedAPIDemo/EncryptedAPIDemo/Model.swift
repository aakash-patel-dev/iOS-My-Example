//
//  Model.swift
//  EncryptedAPIDemo
//
//  Created by P21-0054 on 07/06/22.
//

import Foundation


class Model : NSObject, NSCoding{

    static let shared = Model()
    
    var file : String!
    var thumb : String!
    var lang_code : String!

    override init() {
        super.init()
    }
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        file = dictionary["file"] as? String ?? ""
        thumb = dictionary["thumb"] as? String ?? ""
        lang_code = dictionary["lang_code"] as? String ?? ""
    }
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if file != nil{
            dictionary["file"] = file
        }
        if thumb != nil{
            dictionary["thumb"] = thumb
        }
        if lang_code != nil{
            dictionary["lang_code"] = lang_code
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         file = aDecoder.decodeObject(forKey: "file") as? String
         thumb = aDecoder.decodeObject(forKey: "thumb") as? String
         lang_code = aDecoder.decodeObject(forKey: "lang_code") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if file != nil{
            aCoder.encode(file, forKey: "file")
        }
        if thumb != nil{
            aCoder.encode(thumb, forKey: "thumb")
        }
        if lang_code != nil{
            aCoder.encode(lang_code, forKey: "lang_code")
        }

    }

}
