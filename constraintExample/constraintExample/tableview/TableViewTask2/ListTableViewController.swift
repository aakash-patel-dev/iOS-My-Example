//
//  ListTableViewController.swift
//  constraintExample
//
//  Created by P21_0105 on 24/01/22.
//

import UIKit

class ListTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var strArray : [String] = []
    var index : Int = 0
     override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
         navigationController?.delegate = self
        tableView.reloadData()
     }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strArray.count
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.textLabel?.text = strArray[indexPath.row].description
        cell.callBack = { cell in
                     let actualIndexPath = tableView.indexPath(for: cell)!
                     print("Button pressed", actualIndexPath)
        }
        print(strArray[indexPath.row].description)
        return cell
    }
    private func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            tableView.beginUpdates()
            strArray.remove(at: indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: )
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()

           }
        
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        tableView.beginUpdates()
        let filterAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, bool) in
                print("Swiped to filter")
            self.openAlert(indexPath: indexPath)
            }
            filterAction.backgroundColor = UIColor.blue
        tableView.endUpdates()
      
        return UISwipeActionsConfiguration(actions: [filterAction])
      
    }
    
    
    func openAlert(indexPath: IndexPath){
        let alert = UIAlertController(title: "Edit Your Data", message: "", preferredStyle: .alert)
        
               alert.addTextField { (textField) in
                   textField.placeholder = "Enter text"
               }

               alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
                   guard let textField = alert?.textFields?[0], let userText = textField.text else { return }
                   self.strArray[indexPath.row] = userText
                   print("User text: \(userText)")
                   self.setupTableView()
               }))

               self.present(alert, animated: true, completion: nil)
    }
  
//    @IBAction func editData(_ sender: Any) {
//        print("hrhhr")
////        let alert = UIAlertController(title: "Great Title", message: "Please input something", preferredStyle: UIAlertController.Style.alert)
////        let action = UIAlertAction(title: "Name Input", style: .default) { (alertAction) in
////          let textField1 = alert.textFields![0] as UITextField
////
////            alert.addTextField { (textField) in
////                textField1.placeholder = "Enter your name"
////            }
////        }
////
////        alert.addAction(action)
////        self.present(alert, animated:true)
//
//
//
//    }
   
    
    func setupTableView() {
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.reloadData()
    }
}
// same as "onactivityresult" code here we can send data from 2nd screen to 1st screeen
extension ListTableViewController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? FormViewController)?.strArray = strArray // Here you pass the to your original view controller
    }
}
