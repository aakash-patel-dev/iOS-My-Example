//
//  FileManager.swift
//  SongPlayList
//
//  Created by P21-0105 on 29/03/22.
//

import Foundation

class FileDownloader {

    static func loadFileSync(url: URL, completion: @escaping (String?, Error?, Bool?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil,true)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil,false)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error,false)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error,false)
        }
    }

    static func isFileDownloaded(url: URL) -> Bool {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        if FileManager().fileExists(atPath: destinationUrl.path) {
         return true
        }           
        else {
            return false
        }
    }
    
    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?,Bool?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil,true)
            
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                {
                                    completion(destinationUrl.path, error,false)
                                }
                                else
                                {
                                    completion(destinationUrl.path, error,false)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, error,false)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl.path, error,false)
                }
            })
            task.resume()
        }
    }
    
    static func loadFileWithOperation(url: URL, completion: @escaping (String?, Error?,Bool?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil,true)
            print("aakash1")
        }
        else
        {
                let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
                    if let localURL = localURL {
                         completion(localURL.path,error,false)
                     }
                }
                task.resume()
            
//            let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
//                if let localURL = localURL {
//                    if let string = try? String(contentsOf: localURL) {
//                        completion(string, error,false)
//                        print("aakash2")
//                    }
//                }
//            }

//            task.resume()
//            let url = URL.init(string: url.path)
//               let request:URLRequest = URLRequest.init(url: url!)
//               downloadTask = self.urlSession.downloadTask(with: request)
//               downloadTask.resume()
            
            
//            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            let task = session.dataTask(with: request, completionHandler:
//            {
//                data, response, error in
//                if error == nil
//                {
//                    if let response = response as? HTTPURLResponse
//                    {
//                        if response.statusCode == 200
//                        {
//                            if let data = data
//                            {
//                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
//                                {
//                                    completion(destinationUrl.path, error,false)
//                                    print("aakash2" + destinationUrl.path)
//                                }
//                                else
//                                {
//                                    completion(destinationUrl.path, error,false)
//                                }
//                            }
//                            else
//                            {
//                                completion(destinationUrl.path, error,false)
//                            }
//                        }
//                    }
//                }
//                else
//                {
//                    completion(destinationUrl.path, error,false)
//                }
//            })
//            task.resume()
//
//        }
            
        }
    }
}
