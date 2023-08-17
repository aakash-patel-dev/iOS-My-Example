//
//  FilterImageViewController.swift
//  ConstraintPractices
//
//  Created by P21-0105 on 14/03/22.
//

import UIKit

class FilterImageViewController: UIViewController {
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
    
     @IBOutlet weak var filterMainImg: UIImageView!
    
    @IBOutlet weak var filterImage: UIView!
    @IBOutlet weak var filterScrollView: UIScrollView!
    var image = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterMainImg.image = image.image
        filterMainImg.contentMode = image.contentMode
        
        var xCoord: CGFloat = 5
           let yCoord: CGFloat = 5
           let buttonWidth:CGFloat = 70
           let buttonHeight: CGFloat = 70
           let gapBetweenButtons: CGFloat = 5
        
        var itemCount = 0
             
        for i in 0..<CIFilterNames.count {
            itemCount = i
                 
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
//            filterButton.addTarget(self, action: #selector(ViewController.filterButtonTapped(_:)), forControlEvents: .TouchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: filterMainImg.image!)
            let filter = CIFilter(name: "\(CIFilterNames[i])" )
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            
            let imageForButton = UIImage(cgImage: filteredImageRef!);
            
            filterButton.setBackgroundImage(imageForButton, for: [])
            xCoord +=  buttonWidth + gapBetweenButtons

            filterImage.addSubview(filterButton)
            
        }
        filterScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+2), height: yCoord)

     }
    
  
 
}
