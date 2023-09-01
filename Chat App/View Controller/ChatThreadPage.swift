//
//  ChatThreadPage.swift
//  Chat App
//
//  Created by Bhautik Rajodiya on 04/08/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct ChatTread{
    var uid: [String]
    var threadID: String
}

class ChatThreadPage: UIViewController {

    @IBOutlet weak var allTreadUserTableView: UITableView!
    
    let db = Firestore.firestore()
    var arr = [ChatTread]()
    var a : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.isHidden = true
        getData()
        allTreadUserTableView.reloadData()
    }
    
    func getData(){
        db.collection("Thread").addSnapshotListener{ [self] snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    arr = snapshot.documents.map{ i in
                        return ChatTread(uid: i["users"] as? [String] ?? ["get nil"],threadID: i["threadID"] as? String ?? "")
                    }
                    print(arr)
                    allTreadUserTableView.reloadData()
                }
            }
            else {
                print(error?.localizedDescription as Any)
            }
        }
    }

}

extension ChatThreadPage : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arr.count)
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allTreadUserTableView.dequeueReusableCell(withIdentifier: "cell") as! TreadUserTableViewCell
        cell.userUidLable.text = arr[indexPath.row].threadID
        a = arr[indexPath.row].uid[0]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let a = storyboard?.instantiateViewController(identifier: "chatPage") as! chatPage
        a.threadID = arr[indexPath.row].threadID
        navigationController?.pushViewController(a, animated: true)
    }
    
}
