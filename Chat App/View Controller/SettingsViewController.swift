//
//  SettingsViewController.swift
//  Chat App
//
//  Created by Bhautik Rajodiya on 26/07/23.
//

struct UserData {
    var name : String
    var password: String
    var uid : String
    var email: String
    var mobilNumber: String
    
    init(dic:DocumentSnapshot) {
        self.name = dic["name"] as? String ?? "nil name"
        self.password = dic["password"] as? String ?? "nil password"
        self.uid = dic["uid"] as? String ?? "nil uid"
        self.email = dic["email"] as? String ?? "nil email"
        self.mobilNumber = dic["mobilNumber"] as? String ?? "nil mobile number"
    }
}

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var userUIDLable: UILabel!
    @IBOutlet weak var userEmailLable: UILabel!
    @IBOutlet weak var userMobileNumberLable: UILabel!
    
    let db = Firestore.firestore()
    var arr : UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.isHidden = true
        getData()
        
    }
    
    @IBAction func logoutButtonAction() {
        neviget()
    }
    
    
    func neviget() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("@@@@@@!!!!!")
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    func getData(){
        db.collection("User").document(Auth.auth().currentUser?.uid ?? "nil").addSnapshotListener{ [self] snapshot, error in
            if let snapshot = snapshot {
                arr = UserData(dic: snapshot)
                userNameLable.text = arr?.name
                userUIDLable.text = arr?.uid
                userEmailLable.text = arr?.email
                userMobileNumberLable.text = arr?.mobilNumber
                print(arr)
            }
        }
    }
}
