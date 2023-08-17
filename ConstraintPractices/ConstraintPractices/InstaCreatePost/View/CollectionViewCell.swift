//
//  CollectionViewCell.swift
//  ConstraintPractices
//
//  Created by P21_0105 on 09/03/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgView.contentMode = .scaleToFill
    }
    
    static var nib : UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
           }

}
