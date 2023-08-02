//
//  ViewController.swift
//  Chat App
//
//  Created by Bhautik Rajodiya on 25/07/23.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonAction() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {[self] result, error in
            if error == nil {
                let a = storyboard?.instantiateViewController(identifier: "TabViewController") as! TabViewController
                navigationController?.pushViewController(a, animated: true)
            }
            else
            {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    
    @IBAction func forgotPasswordButtonAction() {
    }
    
    
    @IBAction func creatAccountButtonAction() {
        let a = storyboard?.instantiateViewController(identifier: "CreatNewAccountPage") as! CreatNewAccountPage
        navigationController?.pushViewController(a, animated: true)
    }
}

