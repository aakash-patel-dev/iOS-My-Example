//
//  GalleryViewController.swift
//  ConstraintPractices
//
//  Created by P21_0105 on 09/03/22.
//

import UIKit
import Photos

class GalleryViewController: UIViewController, didChangeImageDelegate {
    func updateImages() {
        self.gallaryCollection.reloadData()
    }
    
    
    // MARK: - Outlets
    
//    @IBOutlet weak var scrollViewImage: UIImageView!
    
    @IBOutlet weak var scrollViewImage: FAScrollView!
    @IBOutlet weak var gallaryCollection: UICollectionView!
    
    @IBOutlet weak var cropBtn: UIButton!
    
    @IBOutlet weak var view_crop: UIView!{
        didSet {
            view_crop.layer.cornerRadius = 5
            view_crop.layer.borderWidth = 3
            view_crop.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    @IBOutlet weak var topConstarint: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraintCropBtn: NSLayoutConstraint!
    //----------------------
    
    // MARK: - Class Variables
    
    private var fltSpace = 0.0
    private var isCropClicked : Bool = false
    private var images = [PHAsset]()
    private let scale = UIScreen.main.scale
    private let manager = PHImageManager.default()
    
    //----------------------
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
        gallaryCollection.delegate = self
        gallaryCollection.dataSource = self
        gallaryCollection.register(CollectionViewCell.nib, forCellWithReuseIdentifier: "cell")
     }

    //----------------------
        
    //MARK:- Action method
    
    @IBAction func cropBtnClick(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.cropBtn.transform = self.cropBtn.transform.rotated(by: CGFloat(Double.pi / 2))
        })
        scrollViewImage.zoom()
        isCropClicked = !isCropClicked
        
        if(isCropClicked){
            UIView.transition(with:   self.scrollViewImage,
                              duration: 0.75,
                              options: .autoreverse,
                              animations: {
                self.scrollViewImage.imageView.contentMode = .scaleAspectFit
            },
                              completion: nil)
        }else{
            UIView.transition(with:   self.scrollViewImage,
                              duration: 0.90,
                              options: .autoreverse,
                              animations: {   self.scrollViewImage.imageView.contentMode = .scaleAspectFill },
                              completion: nil)
        }
    }
    
    @IBAction func goToFilterScreeen(_ sender: Any) {
//        guard let imageToCrop = scrollViewImage.image else {
//            return
//        }

//        let cropRect = CGRect(x: view_crop.frame.origin.x - scrollViewImage.realImageRect().origin.x,
//                              y: view_crop.frame.origin.y - scrollViewImage.realImageRect().origin.y,
//                              width: view_crop.frame.width,
//                              height: view_crop.frame.height)
//
//        let croppedImage = ImageCropHandler.sharedInstance.cropImage(imageToCrop,
//                                                                     toRect: cropRect,
//                                                                     imageViewWidth: scrollViewImage.frame.width,
//                                                                     imageViewHeight: scrollViewImage.frame.height)
//        imageScollview.zoomScale = 1
        
        let croppedImage = captureVisibleRect()

        let viewController = storyboard?.instantiateViewController(withIdentifier: "FilterCollectionViewController") as! FilterCollectionViewController
        viewController.image.image = croppedImage
        viewController.image.contentMode = scrollViewImage.contentMode
        viewController.didChangeimageDelegate = self
        navigationController!.pushViewController(viewController, animated: true)
    }
    
    
    // MARK: - Private Funcations
    
    private func captureVisibleRect() -> UIImage{
        
        var croprect = CGRect.zero
        let xOffset = (scrollViewImage.imageToDisplay?.size.width)! / scrollViewImage.contentSize.width;
        let yOffset = (scrollViewImage.imageToDisplay?.size.height)! / scrollViewImage.contentSize.height;
        
        croprect.origin.x = scrollViewImage.contentOffset.x * xOffset;
        croprect.origin.y = scrollViewImage.contentOffset.y * yOffset;
        
        let normalizedWidth = (scrollViewImage?.frame.width)! / (scrollViewImage?.contentSize.width)!
        let normalizedHeight = (scrollViewImage?.frame.height)! / (scrollViewImage?.contentSize.height)!
        
        croprect.size.width = scrollViewImage.imageToDisplay!.size.width * normalizedWidth
        croprect.size.height = scrollViewImage.imageToDisplay!.size.height * normalizedHeight
        
        let toCropImage = scrollViewImage.imageView.image?.fixImageOrientation()
        let cr: CGImage? = toCropImage?.cgImage?.cropping(to: croprect)
        let cropped = UIImage(cgImage: cr!)
        
        return cropped

    }
    private func isSquareImage() -> Bool{
        let image = scrollViewImage.imageToDisplay
        if image?.size.width == image?.size.height { return true }
        else { return false }
    }
    

    


    // MARK: Public Functions

    func selectImageFromAssetAtIndex(index:NSInteger){
        
//        FAImageLoader.imageFrom(asset: photos[index], size: PHImageManagerMaximumSize) { (image) in
//            DispatchQueue.main.async {
//                self.displayImageInScrollView(image: image)
//            }
//        }
    }

    func displayImageInScrollView(image:UIImage){
        scrollViewImage.imageToDisplay = image
//        if isSquareImage() { btnZoom.isHidden = true }
//        else { btnZoom.isHidden = false }
    }
    
    private func moveTop() {
        topConstraintCropBtn.priority = .defaultLow
        topConstarint.priority = .defaultHigh
    }
    
    private func moveToDown(){
        topConstraintCropBtn.priority = .defaultHigh
        topConstarint.priority = .defaultLow
    }
    
    //----------------------
}

extension GalleryViewController{
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assets.enumerateObjects { (object,_, _) in
                    self?.images.append(object)
                    DispatchQueue.main.async {
                        self?.manager.requestImage(for: object, targetSize:  CGSize(width: (self?.scrollViewImage.frame.size.width)! * self!.scale, height: (self?.scrollViewImage.frame.size.height)! * self!.scale), contentMode: .aspectFill, options: nil)
                        { image, _ in
                            
                            self?.scrollViewImage.imageToDisplay = image
                            self?.scrollViewImage.contentMode = .scaleAspectFill
                        }
                    }
                }
                DispatchQueue.main.async {
                    self?.images.reverse()
                    self?.gallaryCollection.reloadData()
                }
            }
        }
    }
    
    //----------------------
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let asset = self.images[indexPath.row]
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 128, height: 128), contentMode: .aspectFill, options: nil) { image, _ in
            cell.imgView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width - 20) / 4, height: (collectionView.bounds.size.width - 20) / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = self.images[indexPath.row]
     
        manager.requestImage(for: asset,  targetSize: CGSize(width: self.scrollViewImage.frame.size.width * scale, height: self.scrollViewImage.frame.size.height * scale), contentMode: .default, options: nil) { image, _ in
            DispatchQueue.main.async {
                self.scrollViewImage.imageToDisplay = image
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == images.count - 1  ){
            UIView.transition(
                with: collectionView, duration: 0.75,
                              options: .autoreverse,
                              animations: {
                self.moveTop()
            },completion: nil)
        }
         
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == 0){
          
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == gallaryCollection{
            if scrollView.contentOffset.y == 0{
                UIView.transition(with : scrollView , duration: 0.30,
                                  options: .autoreverse,animations: {
                    self.moveToDown()
                }, completion: nil)
            }
        }
     }
    
}
