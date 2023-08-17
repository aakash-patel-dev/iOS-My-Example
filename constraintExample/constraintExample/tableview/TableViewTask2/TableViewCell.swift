//
//  TableViewCell.swift
//  constraintExample
//
//  Created by P21_0105 on 24/01/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var callBack : ((UITableViewCell) -> Void)?
    
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func editData(_ sender: Any) {
        callBack?(self)
    }
    
}
