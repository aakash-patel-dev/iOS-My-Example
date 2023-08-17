//
//  DownlaodManager.swift
//  SongPlayList
//
//  Created by P21-0105 on 05/04/22.
//

import Foundation


class DownloadOperation : Operation {

    private var task : URLSessionDataTask!
//    var currentSession: URLSession
    enum OperationState : Int {
        case ready
        case executing
        case finished
    }
    private var observation: NSKeyValueObservation?
    @objc dynamic var currentProgress = 0.0
    
    var valueDidChangedClouser: ((Float)->())?
    
    
    // default state is ready (when the operation is created)
   
    private var state : OperationState = .ready {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isReady: Bool { return state == .ready }
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
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
    
    deinit {
      observation?.invalidate()
    }
    
     convenience init(session: URLSession, downloadTaskURL: URL, completionHandler: ((URL?, URLResponse?, Error?) -> Void)?) {
         self.init()
//        super.init()
//        currentSession = session
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(downloadTaskURL.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            self.state = .finished
            completionHandler!(destinationUrl, nil,nil)
        }
        else
        {
            var request = URLRequest(url: downloadTaskURL)
            request.httpMethod = "GET"
            task = session.dataTask(with: request, completionHandler:
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
                                    self.state = .finished
                                    completionHandler!(destinationUrl, response,error)
                                }
                                else
                                {
                                    self.state = .finished
                                    completionHandler!(destinationUrl, response,error)
                                }
                            }
                            else
                            {
                                self.state = .finished
                                completionHandler!(destinationUrl, response,error)
                            }
                        }
                    }
                }
                else
                {
                    completionHandler!(destinationUrl, response,error)
                }
            })
            observation = task.progress.observe(\.fractionCompleted) { progress, _ in
                  print("progress: ", progress.fractionCompleted)
                self.currentProgress = progress.fractionCompleted
                self.valueDidChangedClouser?(Float(progress.fractionCompleted))
                }
//            task.resume()
        }
        

        
        
    }
    
    override func start() {
        /*
         if the operation or queue got cancelled even
         before the operation has started, set the
         operation state to finished and return
         */
        if(self.isCancelled) {
            state = .finished
            return
        }
        
        // set the state to executing
        state = .executing
        
 
            // start the downloading
            self.task!.resume()
    }
    
    override func cancel() {
        super.cancel()
        // cancel the downloading
        self.task.cancel()
    }
    
     func pauseDownload(){
         
         self.task.suspend()
    }
    func resumeDownload(){
        self.task.resume()
     }
}
