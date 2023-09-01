//
//  ViewController3.swift
//  Chat App
//
//  Created by Bhautik Rajodiya on 26/07/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct ChatData {
    var meseg : String
    var sender : String
    var time : Date
    var dataTypes : String
    var imagePath : String
    
    init(dic:QueryDocumentSnapshot) {
        self.meseg = dic["Meseg"] as? String ?? "nil meseg"
        self.sender = dic["Sender"] as? String ?? "nil sender"
        self.time = (dic["Time"] as! Timestamp).dateValue()
        self.dataTypes = dic["dataType"] as? String ?? "Message"
        self.imagePath = dic["imgPath"] as? String ?? ""
    }
}

class chatPage: UIViewController {
    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    let db = Firestore.firestore()
    var uid = Auth.auth().currentUser?.uid
    var threadID : String = ""
    var arr = [ChatData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.isHidden = true
        chatTextField.layer.cornerRadius = 10
        title = threadID
        getData()
    }
    
    @IBAction func chatSendButton() {
        let dic = ["Meseg":chatTextField.text as Any,"Time":Date(),"Sender":uid as Any, "dataType":"Message","imgPath":""]
        db.collection("Thread").document(threadID).collection("Chat").addDocument(data: dic) {[self] error in
            if error == nil {
                chatTextField.text = ""
            }
        }
    }
    
    func getData(){
        db.collection("Thread").document(threadID).collection("Chat").order(by: "Time", descending: false).addSnapshotListener {[self] snapshot, error in
            if let snapshot = snapshot {
                arr = snapshot.documents.map{ i in ChatData(dic: i) }
                print(arr)
                chatTableView.reloadData()
                if arr.count == 0 {
                    
                } else {
                    
                    chatTableView.scrollToRow(at: IndexPath(row: arr.count - 1, section:0 ), at: .bottom, animated: true)
                }
                
            }
        }
    }
    
    
    func dateToString(date:Date)->String{
        var helper = DateFormatter()
        helper.dateFormat = "hh:mm a"
        return helper.string(from: date)
    }
    
}


extension chatPage : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arr[indexPath.row].sender != Auth.auth().currentUser?.uid {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1") as! TableViewCell1
            cell1.lable1.text = arr[indexPath.row].meseg
            return cell1
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! TableViewCell2
        cell.lable2.text = arr[indexPath.row].meseg
        cell.dateLable.text = dateToString(date: arr[indexPath.row].time)
        return cell
        
    }
    
    
}
