//
//  CollectionViewController.swift
//  constraintExample
//
//  Created by P21_0105 on 25/01/22.
//

import UIKit

class CollectionViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource {
    
 
    @IBOutlet weak var collectionview: UICollectionView!
    
    var imagesLabel : [String] = ["test","test","test","test","test","test" ,"test","test","test" ,"test","test","test" ,"test","test","test","test","test","test"]
    var imgArr = Array<UIImage?>()
  
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesLabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RowCollectionViewCell
        cell.myLabel.text = imagesLabel[indexPath.row]
//        cell.myLabel.text = imagesLabel[indexPath.row]
       // cell.imageView.image = imgArr[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       

        collectionview.dataSource = self
        collectionview.delegate = self
//        imgArr = [ UIImage(named:  "a"), UIImage(named:  "b"), UIImage(named:  "c"),  ]
        // Do any additional setup after loading the view.
    }
    
 
}
