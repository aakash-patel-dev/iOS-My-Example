//
//  APIManager.swift
//  SongPlayList
//
//  Created by P21-0105 on 25/03/22.
//

import UIKit

class APIManager: NSObject {
    static func getWebService(_ apiURL: String, completionHandler: @escaping (_ dictResponse: Dictionary<String, AnyObject>?, _ error: Error?) -> ()){
        let request = URLRequest(url: URL(string: apiURL)!)
//        request.allHTTPHeaderFields = createHeaders()
        let getTask = URLSession.shared.dataTask(with: request) { (responseData, _, error) in
            DispatchQueue.main.async {
                do {
                    if responseData != nil {
                        let json = try JSONSerialization.jsonObject(with: responseData!, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, AnyObject>
                        if let parsedJSON = json {
                            //Json Parsed Successfully
                            print(parsedJSON)
                            completionHandler(parsedJSON, nil)
                        } else {
                            //Cannot parse json or data must be nil
                            let jsonStr = String(data: responseData!, encoding: String.Encoding.utf8)
                            #if DEBUG
                                print("Error could not parse JSON: \(jsonStr ?? "")")
                            #endif
                        }
                    } else {
                        completionHandler(nil, error)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil, error)
                }
            }
        }
        getTask.resume()
    }
}
