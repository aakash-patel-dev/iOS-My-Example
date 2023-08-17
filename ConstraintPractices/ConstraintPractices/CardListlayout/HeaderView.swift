//
//  HeaderView.swift
//  ConstraintPractices
//
//  Created by P21_0105 on 16/02/22.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var label: UILabel!
    
    static var nib : UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    

}
