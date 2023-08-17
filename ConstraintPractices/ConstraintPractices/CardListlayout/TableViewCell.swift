//
//  TableViewCell.swift
//  ConstraintPractices
//
//  Created by P21_0105 on 16/02/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var arroeBtn: UIButton!
    
    
    @IBOutlet weak var amountLimit: UILabel!
    
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    
    @IBOutlet weak var cvvNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    override func layoutSubviews() {
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 10))
        parentView.layer.cornerRadius = 10
        arroeBtn.layer.cornerRadius = 15
    }
    
    
    static var nib : UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    
}
