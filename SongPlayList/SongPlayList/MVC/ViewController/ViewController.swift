//
//  ViewController.swift
//  SongPlayList
//
//  Created by P21-0105 on 25/03/22.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
 
    
    // MARK: - Class Outlets
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: - Class Variables
    var songsList = [Result.init(fromDictionary: [:])]
    var player = AVAudioPlayer()
    var isAudioplay : Bool = false
    let operationQue = OperationQueue()
    var session : URLSession!
    var queue : OperationQueue!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        getPurchasePhoneNumberFromRestore()
        queue = OperationQueue()
     
        queue.maxConcurrentOperationCount = 1
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    }
    
    // MARK: - API Calling
    
    func getPurchasePhoneNumberFromRestore() {
        APIManager.getWebService(APIList.DomainURL, completionHandler: { (responseData, error) in
            
            if let error = error {
                print("error - \(error.localizedDescription)")
            }
            else {
                if let arrReponseData = responseData!["results"] as? Array<Dictionary<String, Any>>,arrReponseData.count > 0 {
                    for data in arrReponseData {
                        
                        var songs = Result(fromDictionary: data)
                        
                        if let strURL = songs.previewUrl, let url = URL.init(string: strURL) {
                                if DownloadOperation.isFileDownloaded(url: url) == true {
                                    songs.currentPlayerStatus = .Paused
                                }
                            
                        }
                        
                        self.songsList.append(songs)
                    }
                }
                
                self.tblView.reloadData()
            }
        })
    }
    
    // MARK: - Class Funcations
    func playSound(url : String, playerStatus : CurrentPlayerStatus) {

        let url = URL(fileURLWithPath: url)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            if(playerStatus == .Played) {
                    player.play()
                }
                else{
                    player.pause()
                }
          
        } catch let error {
            print(error.localizedDescription + "error-aakash")
        }
    }
    
    func reloadData(){
        if let row = self.songsList.firstIndex(where: {$0.currentPlayerStatus == .Played}) {
            self.songsList[row].currentPlayerStatus =  .Paused
            self.tblView.reloadRows(at: [IndexPath.init(row: row, section: 0)], with: .none)
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource,cellDelegate{
     func didDownloadpressed(image: UIImage, tableViewCell: UITableViewCell) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let dictResult = songsList[indexPath.row]
        cell.btnImage.tag = indexPath.row
        cell.downlaodPauseResume.tag = indexPath.row
        cell.progressBar.isHidden = true
        cell.progressVw.isHidden = true
        cell.btnImage.isHidden = false
        cell.btnImage.addTarget(self, action: #selector(playPause(sender:)), for: .touchUpInside)
        cell.downlaodPauseResume.addTarget(self, action: #selector(playPauseDownload(sender:)), for: .touchUpInside)
        cell.setData(dict: dictResult)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func playPauseDownload(sender : UIButton){
        self.songsList[sender.tag].isDwnldPause = !self.songsList[sender.tag].isDwnldPause
        let cell = self.tblView.cellForRow(at: IndexPath.init(row: sender.tag, section: 0)) as! TableViewCell
//        if let currentQueue = queue.operations.filter({$0.name == "\(sender.tag)"}).first {
//
//           print("is downloaded : \(currentQueue.isFinished)")
//            print("is executing : \(currentQueue.isExecuting)")
//        }
//
//
//        for i in queue.operations{
//
//            if let name = i.name {
//                print(name + "aakash")
//            }
//
//        }
        
      
//        progressVw.isHidden = progressVw.progress > 0.0 ? false : true
//        progressVw.progress = Float(operationInstance?.currentProgress ?? 0.0)
        
        if(self.songsList[sender.tag].isDwnldPause){
            cell.operationInstance?.pauseDownload()
          //  DownloadOperation.sharedInstance.pauseDownload()
            cell.downlaodPauseResume.setTitle("Resume", for: .normal)
            cell.progressBar.stopAnimating()
        }
        else{
            cell.operationInstance?.resumeDownload()
            cell.downlaodPauseResume.setTitle("Pause", for: .normal)
            cell.progressBar.startAnimating()
        }
        
        
    }
    
    @objc func playPause(sender : UIButton){
        let completionOperation = BlockOperation {
        }
           
        let cell = self.tblView.cellForRow(at: IndexPath.init(row: sender.tag, section: 0)) as! TableViewCell

        if let strPrv = songsList[sender.tag].previewUrl, let url = URL(string: strPrv) {
                DispatchQueue.main.async {
                    cell.btnImage.isHidden = true
                    cell.progressBar.isHidden = false
                    cell.progressBar.startAnimating()
                }
    

              let operation = DownloadOperation(session: self.session, downloadTaskURL: url, completionHandler: { (localURL, urlResponse, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            if self.songsList[sender.tag].currentPlayerStatus == .DownloadPending {
                                self.reloadData()
                                self.songsList[sender.tag].currentPlayerStatus = .Played
                            } else {
                                if self.songsList[sender.tag].currentPlayerStatus == .Played {
                                    self.songsList[sender.tag].currentPlayerStatus = .Paused
                                    
                                } else {
                                    self.reloadData()
                                    self.songsList[sender.tag].currentPlayerStatus = .Played
                                }
                            }
                            cell.progressBar.stopAnimating()
                            cell.btnImage.isHidden = false
                            cell.progressBar.isHidden = true
                            
                            self.playSound(url: localURL!.path, playerStatus : self.songsList[sender.tag].currentPlayerStatus)
                            self.tblView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: .none)
                            
                        }
                    }
                })
            operation.valueDidChangedClouser = { (value) in
                DispatchQueue.main.async {
                    cell.progressVw.progress = value
                    
                    cell.progressVw.isHidden = (value == 1.0) ? true : ( value > 0.0 ? false : true)
                    
                }
                
            }
            
            cell.operationInstance = operation
            operation.name = "\(sender.tag)"
                completionOperation.addDependency(operation)
                self.queue.addOperation(operation)
//                FileDownloader.loadFileAsync(url: url) { (path, error,isExists) in
//
//                    DispatchQueue.main.async {
//
//
//                        if self.songsList[sender.tag].currentPlayerStatus == .DownloadPending {
//                            self.songsList[sender.tag].currentPlayerStatus = .Played
//                        } else {
//                            if self.songsList[sender.tag].currentPlayerStatus == .Played {
//                                self.songsList[sender.tag].currentPlayerStatus = .Paused
//
//                            } else {
//                                if let row = self.songsList.firstIndex(where: {$0.currentPlayerStatus == .Played}) {
//                                    self.songsList[row].currentPlayerStatus =  .Paused
//                                    self.tblView.reloadRows(at: [IndexPath.init(row: row, section: 0)], with: .none)
//                                }
//                                self.songsList[sender.tag].currentPlayerStatus = .Played
//                            }
//                        }
//                        cell.progressBar.stopAnimating()
//                        cell.btnImage.isHidden = false
//                        cell.progressBar.isHidden = true
//                        self.playSound(url: path!, playerStatus : self.songsList[sender.tag].currentPlayerStatus ,index : self.selectedIndex)
//
//                        self.tblView.reloadRows(at: [IndexPath.init(row: self.selectedIndex, section: 0)], with: .none)
//
//                    }
//
//                }
            
        }
        
        self.queue.addOperation(completionOperation)
    }
}



