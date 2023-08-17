//
//  TableViewController.swift
//  constraintExample
//  
//  Created by P21_0105 on 21/01/22.
//

import UIKit

class TableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableVIew: UITableView!
    var countryNames: [String] = ["India" ,"US", "Australia", "England", "Germany"]
        var cityNames: [String] = ["New Delhi" ,"Washington", "Melbourne", "London", "Berlin"]
    var dataModels = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<5{
                  
                  self.dataModels.append(DataModel(country: countryNames[i], city:  cityNames[i]))
                  //displaying data in tableview
                  tableVIew.reloadData()
                  
              }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13, *)
        {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
                  statusBar.backgroundColor = .yellow
                      statusBar.tag = 100
                  UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TextTableViewCell
                
                //getting the hero for the specified position
                let model: DataModel
                
                model = dataModels [indexPath.row]
                
                //displaying values
                cell.countryName.text = model.country
                cell.cityName.text = model.city
                
                return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selcected"+dataModels[indexPath.row].city!.description)
        
        let viewController = 	storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
      
        viewController.str = "Welcome to \(dataModels[indexPath.row].city!.description)"
        navigationController?.pushViewController(viewController, animated: true)
    }
    

    
    

    

 
}
extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
