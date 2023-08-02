//
//  SettingsViewController.swift
//  Chat App
//
//  Created by Bhautik Rajodiya on 26/07/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logoutButtonAction() {
        neviget()
    }
    
    
    func neviget() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("@@@@@@!!!!!")
            let a = storyboard?.instantiateViewController(withIdentifier: "ViewController4") as! ViewController4
            navigationController?.popViewController(animated: true)

        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        
    }
}
