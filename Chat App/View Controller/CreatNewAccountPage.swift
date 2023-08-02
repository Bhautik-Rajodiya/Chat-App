//
//  CreatNewAccountPage.swift
//  Chat App
//
//  Created by Bhautik Rajodiya on 25/07/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class CreatNewAccountPage: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var conframPasswordTextField: UITextField!
    
    var ref : Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Firestore.firestore()
    }

    @IBAction func saveButtonAction() {
        if nameTextField.text == "" || emailTextField.text == "" || mobileNumberTextField.text == "" || newPasswordTextField.text == "" || conframPasswordTextField.text == "" {
            alert()
        }
        else {
            creatAccount()
        }
    }
    
    func creatAccount() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: conframPasswordTextField.text!) { [self] authDataResult, error in
            if error == nil {
                print(authDataResult?.user.uid as Any)
                
                let dic = [
                    "name":nameTextField.text ?? "",
                    "email":emailTextField.text ?? "",
                    "mobilNumber":mobileNumberTextField.text ?? "",
                    "password":conframPasswordTextField.text ?? ""
                ] as [String : Any]
                
                ref.collection("User").document((authDataResult?.user.uid)!).setData(dic)
                neviget()
            }
            else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func alert(){
        let a = UIAlertController(title: "Error", message: "Enter Full Details", preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "ok", style: .default))
        present(a, animated: true)
    }
    
    func neviget() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
