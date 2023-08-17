//
//  ViewController.swift
//  EncryptedAPIDemo
//
//  Created by P21_0025 on 08/03/22.
//

import UIKit
import Alamofire
import RNCryptor

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
    }
}

extension ViewController{
    
    private func createTestEncryptString(){
        
        var parameters = [String:Any]()
        parameters["guestId"] = "Guest-4EAA2B9D-1A39-445C-AE6D-7C1DC0109D9B"
        parameters["deviceType"] = 1
        parameters["deviceToken"] = 123
        parameters["osName"] = "iOS $$$$$ 🌰"
        parameters["osVersion"] = 6
        parameters["deviceName"] = "test ++++++ 🍰"
        parameters["timezone"] = "Asia/Kolkata"
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            //Encryption
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                
                let password = "qazcdewsx"
                
                let ciphertext = RNCryptor.encrypt(data: jsonData, withPassword: password)
                debugPrint("Encrypted Parameters ===== ", ciphertext)
                
                var request = URLRequest(url: URL(string: "http://157.230.229.95/2ndLine/web/api/v202203/user_add2_db")!)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                request.httpBody = Data(ciphertext.base64EncodedString().utf8)

                let responseString = Data(base64Encoded: "AwGpQ+9cmNj5muXqBPNsqcRS05rCxKkpHU4p79arVCkhuWYIzRI48Op1iVj474W2ZpYNw8PIwykWFXpz++dKmJCjpV38rbckFpQmxukClE0jqg7oPFd1//URkIfu8WvfrivFgR4gC/y+TRWrB2ecynh9YDEiDlxeFRHxj8ECVARXGnSGGwwmtHxDseHhQg/KTMwpViNEjEouWpkWtKocUjf3nlgntwNLjIqbkycu9I8BCa5+2ErvX2liPOX84rMDxtlCJ/DmzgVwIJRcNul3FzftF71DkNlggEuawI7HNgVk7DeTkazMX6cCGFfPhB9d2X4JBGtBneQpIFZ/0Pr4zAJS3I+y8izL1ATSblXPCVxDjf/b/Y8ZvxmfsYlUQi5Lfs/oU4mo6oRjw5yu4i4qGIup")
                
                let decrypt = try RNCryptor.decrypt(data: responseString!, withPassword: password)
                debugPrint("decrypted data ============ ",decrypt)
                
                do {
                    let dict = try JSONSerialization.jsonObject(with: decrypt, options: [.fragmentsAllowed])
                    debugPrint("decrypted text ============ ",dict)
                } catch {
                    print(error.localizedDescription)
                }
                
                AF.request(request).responseJSON { (response) in
                    switch response.result {
                    case .success(let json):
                        print(json)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }catch{
            debugPrint(error.localizedDescription)
        }
    }
}

extension ViewController{
    
    private func setupUI(){
        
        let action = UIAction { [weak self] action in
            if self == nil{
                return
            }
            self!.createTestEncryptString()
        }
        
        let btnSubmit = UIButton(configuration: .filled(), primaryAction: action)
        btnSubmit.translatesAutoresizingMaskIntoConstraints = false
        btnSubmit.setTitle("Submit", for: .normal)
        view.addSubview(btnSubmit)
        
        let margin = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            btnSubmit.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            btnSubmit.centerYAnchor.constraint(equalTo: margin.centerYAnchor),
        ])
    }
}

extension ViewController{
    
    private func callEncryptedAPI(){
        
    }
}
