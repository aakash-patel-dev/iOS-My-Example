//
//  DemoVC.swift
//  EncryptedAPIDemo
//
//  Created by P21-0054 on 03/05/22.
//

import UIKit

class DemoVC: UIViewController {

    @IBOutlet var colView: UICollectionView!
    
    let imgArr = ["1", "2", "3", "4", "3", "2", "1", "4", "1", "2", "3", "4"]
    let section = ["First Section", "Second Section", "Third Section"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colView.collectionViewLayout = createCompositionalLayout()
    }
    
}

//MARK:- Compositional Layout
extension DemoVC {
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            
            //MARK:- Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(sectionIndex == 1 ? 0.33
                                                                                   : 1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            //MARK:- Group
            let groupWidth =  NSCollectionLayoutDimension.fractionalWidth(1)

            let groupHeight = NSCollectionLayoutDimension.fractionalWidth(0.5)

            let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//            sectionIndex == 1 ? NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns) : NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
            
            //MARK:- Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = sectionIndex == 1 ? .paging : .none
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            //MARK:- For Bonus Round (Bouncing Cells)
//            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
//                items.forEach { item in
//                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
//                    let minScale: CGFloat = 0.8
//                    let maxScale: CGFloat = 1.2
//                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
//                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
//                }
//            }

            return section
        }
        return layout
    }
}

extension DemoVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.imgView.image = UIImage(named: imgArr[indexPath.row])
        cell.lblTitle.text = "Index \(indexPath.row)"
        return cell
    }
    
}


class TestCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        imgView.layer.cornerRadius = 10
    }
}
