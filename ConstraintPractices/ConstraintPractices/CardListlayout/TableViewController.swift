//
//  TableViewController.swift
//  ConstraintPractices
//
//  Created by P21_0105 on 16/02/22.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var tblView: UITableView!
    var modelArray = [DataModel]()
     @IBOutlet weak var addBtn: UIButton!
    let floatingButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(TableViewCell.nib, forCellReuseIdentifier: "cell")
        tblView.register(HeaderView.nib, forCellReuseIdentifier: "header")


        addBtn.layer.cornerRadius = addBtn.frame.height / 2
        addBtn.clipsToBounds = true
        
    }

 

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
          return modelArray.count
    }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
          if indexPath.row == 0{
              cell.parentView.backgroundColor = UIColor.purple
              cell.arroeBtn.backgroundColor = UIColor.systemYellow
          }
          else if indexPath.row == 1{
              cell.parentView.backgroundColor = UIColor.systemYellow
              cell.arroeBtn.backgroundColor = UIColor.purple
          }
          else{
              cell.parentView.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
              cell.arroeBtn.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
          }
      
          
          cell.customerName.text = modelArray[indexPath.row].customerName
          cell.cardNumber.text = modelArray[indexPath.row].cardNumber
          cell.amountLimit.text = modelArray[indexPath.row].amount
          cell.cvvNum.text = modelArray[indexPath.row].cvvNum
          cell.selectionStyle = .none
         return cell
    }
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    @IBAction func addCard(_ sender: Any) {
        
        openAlert()
    }
    
    
    func openAlert(){
        let alert = UIAlertController(title: "Add Your Data", message: "", preferredStyle: .alert)
        
               alert.addTextField { (nameText) in
                   nameText.placeholder = "Enter Name"
               }
                alert.addTextField { (cardNum) in
                    cardNum.placeholder = "Enter CardNumber"
                }
        
                alert.addTextField { (cvvText) in
                    cvvText.placeholder = "Enter CVV"
                }

                alert.addTextField { (amountlimit) in
                    amountlimit.placeholder = "Enter Amount Limit"
                }
               alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
                   guard let customerName = alert?.textFields?[0] ,let _ = customerName.text else { return }
                   
                   guard let amount = alert?.textFields?[1], let _ = amount.text else { return }
                   
                   guard let cardNumber = alert?.textFields?[2], let _ = cardNumber.text else { return }
                   
                   guard let cvvNum = alert?.textFields?[3], let _ = cvvNum.text else { return }
                   
                   let model = DataModel(amount: amount.text, cardNumber:  cardNumber.text, customerName: customerName.text , cvvNum: cvvNum.text)
                   
                   
                   self.modelArray.append(model)
                   self.tblView.reloadData()

               }))

               self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
//     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! HeaderView
//        view.label.text = "Credit Card Manager"
//        return view
//    }
//     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        customView.center = self.view.center
//         let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        button.setTitle("+", for: .normal)
//        button.layer.cornerRadius = 25
//        button.backgroundColor = UIColor.blue
//        customView.addSubview(button)
//        return customView
//    }

}
