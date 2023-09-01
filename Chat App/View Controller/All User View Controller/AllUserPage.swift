//
//  AllUserPage.swift
//  Chat App
//
//  Created by Bhautik Rajodiya on 26/07/23.
//

struct User {
    var name : String
    var id: String
}

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class AllUserPage: UIViewController {
    
    @IBOutlet weak var allUserTableView: UITableView!
    
    let db = Firestore.firestore()
    var arr = [User]()
    var uid = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.isHidden = true
        getData()
    }
    
    func getData(){
        db.collection("User").getDocuments{ [self] snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    arr = snapshot.documents.map{ i in
                        return User(name: i["name"] as! String, id: i["uid"] as? String ?? "get nil")
                    }
                    print(arr)
                    allUserTableView.reloadData()
                }
            }
            else {
                print(error?.localizedDescription as Any)
            }
        }
    }

}

extension AllUserPage : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arr.count)
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allUserTableView.dequeueReusableCell(withIdentifier: "cell") as! UserTableViewCell
        cell.nameLable.text = arr[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if arr[indexPath.row].id == uid {
            print("uid same")
        }
        else {
            var a = db.collection("Thread").document()
            let dic = [
                "users":[arr[indexPath.row].id,uid],
                "threadID":a.documentID
            ] as [String : Any]
            a.setData(dic)
            self.tabBarController?.selectedIndex = 0
        }
        
    }
    
}
