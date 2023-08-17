//
//  FilterCollectionViewController.swift
//  ConstraintPractices
//
//  Created by P21-0105 on 15/03/22.
//

import UIKit
import Photos
protocol didChangeImageDelegate{
    func updateImages()
}
class FilterCollectionViewController : UIViewController{
    

    // MARK: - Outlets
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    // MARK: - Class Variables
    
    let scale = UIScreen.main.scale
    let manager = PHImageManager.default()
    let ciContext = CIContext(options: nil)
    var CIFilterNames = [
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone"
    ]
    var image = UIImageView()
     var fltSpace = 0.0
    var didChangeimageDelegate : didChangeImageDelegate?
      // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImg.image = image.image
         mainImg.contentMode = image.contentMode
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(CollectionViewCell.nib, forCellWithReuseIdentifier: "cell")
    }
    
    // MARK: - Action Methods
    
    @IBAction func saveFilteredImage(_ sender: Any) {
        
        saveImageToDocumentDirectory(mainImg.image!)
        
    }
    
    @IBAction func closeFilterScr(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
}

extension FilterCollectionViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.CIFilterNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imgView.image = filteredImage(indexPath: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        fltSpace = collectionView.frame.size.width * 0.032
//        return CGSize(width: collectionView.frame.size.width/3.2, height:  collectionView.frame.size.width/3.2)
                return CGSize(width: (collectionView.frame.size.width - 25) / 2 , height:  (collectionView.frame.size.width - 25) / 2)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
//        return fltSpace
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainImg.image = filteredImage(indexPath: indexPath.row)
    }
    
}

extension FilterCollectionViewController {
    
    func filteredImage(indexPath : Int) -> UIImage {
        let coreImage = CIImage(image: image.image!)
        let filter = CIFilter(name: "\(CIFilterNames[indexPath])" )
        filter!.setDefaults()
        filter!.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
        let imageForButton = UIImage(cgImage: filteredImageRef!);
        return imageForButton
    }
    
    func saveImageToDocumentDirectory(_ chosenImage: UIImage)  {
        
        UIImageWriteToSavedPhotosAlbum(chosenImage, self, nil, nil)
        let alert = UIAlertController(title: "Success", message: "Image Successfully exported", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: {
            action in
            switch action.style {
                
            case .cancel:
                print("")
            case .destructive:
                print("")
            case .default:
                self.didChangeimageDelegate?.updateImages()
            @unknown default:
                print("")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

