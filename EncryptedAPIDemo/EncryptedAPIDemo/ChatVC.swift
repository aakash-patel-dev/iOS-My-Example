//
//  ChatVC.swift
//  EncryptedAPIDemo
//
//  Created by P21-0054 on 30/08/22.
//

import UIKit
import IQKeyboardManagerSwift

class ChatVC: UIViewController {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtField: UITextField!
    
    var chatArr: [ChatModel]!
//    ["Lorem Ipsum is simply d text of the printing and typesetting industry.", "Lorem Ipsum is simply", "Lorem Ipsum", "dummy text of the printing and typesetting industry.", "Lorem Ipsum is simply d text of the printing and typesetting industry.", "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.", "Lorem Ipsum", "dummy text of the printing and typesetting industry.", "Lorem Ipsum is simply d text of the printing and typesetting industry.", "Lorem Ipsum is simply", "Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.", "Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more"]
    let imgArr = ["1", "2", "3", "4", "1", "2", "3", "4", "1", "2", "3", "4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatArr = [
            ChatModel(imgUser: "1", media: "2", username: "Vishal Kumar", msg: "Hello", date: "12:02pm", isLoggedInUser: false, type: 0),
            ChatModel(imgUser: "2", media: "4", username: "Abhishek Sharma", msg: "Hello", date: "12:02pm", isLoggedInUser: true, type: 1),
            ChatModel(imgUser: "3", media: "1", username: "Abhishek Sharma", msg: "How are you", date: "12:02pm", isLoggedInUser: true, type: 0),
            ChatModel(imgUser: "4", media: "2", username: "Vishal Kumar", msg: "I am fine, what about you?", date: "12:02pm", isLoggedInUser: false, type: 1),
            ChatModel(imgUser: "1", media: "1", username: "Vishal Kumar", msg: "Latin professor at Hampden-Sydney College", date: "12:02pm", isLoggedInUser: false, type: 0),
            ChatModel(imgUser: "2", media: "4", username: "Abhishek Sharma", msg: "Latin professor at Hampden-Sydney College", date: "12:02pm", isLoggedInUser: true, type: 1),
            ChatModel(imgUser: "3", media: "3", username: "Vishal Kumar", msg: "Latin professor at Hampden-Sydney College", date: "12:02pm", isLoggedInUser: false, type: 0),
            ChatModel(imgUser: "4", media: "2", username: "Vishal Kumar", msg: "Latin professor at Hampden-Sydney College", date: "12:02pm", isLoggedInUser: false, type: 1),
            ChatModel(imgUser: "1", media: "1", username: "Abhishek Sharma", msg: "Latin professor at Hampden-Sydney College", date: "12:02pm", isLoggedInUser: true, type: 0),
            ChatModel(imgUser: "2", media: "3", username: "Vishal Kumar", msg: "Latin professor at Hampden-Sydney College", date: "12:02pm", isLoggedInUser: false, type: 1),
            ChatModel(imgUser: "3", media: "1", username: "Abhishek Sharma", msg: "Latin professor at Hampden-Sydney College", date: "12:02pm", isLoggedInUser: true, type: 0),
            ChatModel(imgUser: "4", media: "4", username: "Vishal Kumar", msg: "Latin professor at Hampden-Sydney College", date: "12:02pm", isLoggedInUser: false, type: 1),
        ]
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.chatArr.count-1, section: 0)
            self.tblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension ChatVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 320, right: 0)
        tblView.reloadData()
        scrollToBottom()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tblView.reloadData()
    }
}

extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatData = chatArr[indexPath.row]
        if chatData.type == 0 {
            if chatData.isLoggedInUser {
                let cell = tableView.dequeueReusableCell(withIdentifier: "fromCell") as! ChatCell
                cell.viewMain.backgroundColor = .systemYellow.withAlphaComponent(0.2)
                cell.lblMsg.text = chatData.msg
                cell.imgView.image = UIImage(named: chatData.imgUser)
                cell.lblName.text = chatData.username
                cell.lblDate.text = chatData.date
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "toCell") as! ChatCell
                cell.viewMain.backgroundColor = .systemCyan.withAlphaComponent(0.2)
                cell.lblMsg.text = chatData.msg
                cell.imgView.image = UIImage(named: chatData.imgUser)
                cell.lblName.text = chatData.username
                cell.lblDate.text = chatData.date
                return cell
            }
        } else {
            if chatData.isLoggedInUser {
                let fromMediaCell = tableView.dequeueReusableCell(withIdentifier: "fromMediaCell") as! ChatMediaCell
                fromMediaCell.viewMain.backgroundColor = .systemYellow.withAlphaComponent(0.2)
                fromMediaCell.img.image = UIImage(named: chatData.imgUser)
                fromMediaCell.imgUser.image = UIImage(named: chatData.media)
                fromMediaCell.lblName.text = chatData.username
                fromMediaCell.lblDate.text = chatData.date
                return fromMediaCell
            } else {
                let toMediaCell = tableView.dequeueReusableCell(withIdentifier: "toMediaCell") as! ChatMediaCell
                toMediaCell.viewMain.backgroundColor = .systemCyan.withAlphaComponent(0.2)
                toMediaCell.img.image = UIImage(named: chatData.imgUser)
                toMediaCell.imgUser.image = UIImage(named: chatData.media)
                toMediaCell.lblName.text = chatData.username
                toMediaCell.lblDate.text = chatData.date
                return toMediaCell
            }
        }
    }
}


class ChatCell: UITableViewCell {
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        self.viewMain.layer.cornerRadius = 10
        self.imgView.layer.cornerRadius = self.imgView.frame.size.height / 2
    }
}

class ChatMediaCell: UITableViewCell {
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        self.viewMain.layer.cornerRadius = 10
        self.imgUser.layer.cornerRadius = self.imgUser.frame.size.height / 2
//        self.img.layer.cornerRadius = 8
    }
}


struct ChatModel {
    var imgUser = String()
    var media = String()
    var username = String()
    var msg = String()
    var date = String()
    var isLoggedInUser: Bool!
    var type = Int()
}
