//
//  TableViewCell.swift
//  SongPlayList
//
//  Created by P21-0105 on 25/03/22.
//

import UIKit

protocol cellDelegate : AnyObject{
    func didDownloadpressed(image : UIImage,tableViewCell : UITableViewCell)
}
class TableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    @IBOutlet weak var downlaodPauseResume: UIButton!
    @IBOutlet weak var progressVw: UIProgressView!
    
    // MARK: - Variables
    var celldelegate : cellDelegate?
    var buttonAction : ((_ sender: AnyObject) -> ())? = nil
//    var buttonAction: (() -> ())? = nil
    var operationInstance : DownloadOperation? = nil

    override func prepareForReuse() {
//        btnImage.isHidden = true
    }
    static var nib : UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
           }
    @IBAction func btnDownload(_ sender: AnyObject) {
        if self.buttonAction != nil {
            self.buttonAction!(sender)
//            var superview = (sender as AnyObject).superview
//            while let view = superview, !(view is UITableViewCell) {
//                superview = view?.superview
//            }
//            guard let cell = superview as? UITableViewCell else {
//                print("button is not contained in a table view cell")
//                return
//            }
//            celldelegate?.didDownloadpressed(image: (btnImage.imageView?.image)!,tableViewCell : cell )
            
        }
//        var superview = (sender as AnyObject).superview
//            while let view = superview, !(view is UITableViewCell) {
//                superview = view?.superview
//            }
//            guard let cell = superview as? UITableViewCell else {
//                print("button is not contained in a table view cell")
//                return
//            }
//
//        celldelegate?.didDownloadpressed(image: (btnImage.imageView?.image)!,tableViewCell : cell )
    }
    
    func setData(dict : Result) {
        musicName.text = dict.collectionName
        
        switch dict.currentPlayerStatus {
        case .DownloadPending :
            btnImage.setImage(UIImage.init(named: "iconDownload"), for: .normal)
            break
            
        case .Played :
            btnImage.setImage(UIImage.init(named: "iconPause"), for: .normal)
            break
            
        case .Paused :
            btnImage.setImage(UIImage.init(named: "iconPlay"), for: .normal)
            break
        }
    }
}
