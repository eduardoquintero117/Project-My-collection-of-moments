//
//  RegisterViewController.swift
//  My collection of moments
//
//  Created by Eduardo Quintero on 11/04/21.
//  Copyright © 2021 new x. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var password1TF: UITextField!
    @IBOutlet weak var loginBTN: UIButton!
    
    
    
    var ref: DocumentReference!
    var getRef: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRef = Firestore.firestore()
    }
    
    @IBAction func loginBTN(_ sender: UIButton) {
        guard let email = emailTF.text, email !=  "" , let password = password1TF.text,  password != "", let name = nameTF.text,  name != "", let lastName = lastNameTF.text,  lastName != "", let userName = userNameTF.text,  userName != "" else {
            self.showMessage(message: "Falta informacion",title: "Alerta")
            return
            
        }
        
       
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return

            }
            //print("usuario creado", user?.user.uid)
            
            self.storeUser(uid: (user?.user.uid)!, name: name, lastName: lastName, userName: userName,email: email)
            
            
        }
        

        
    }

    
    func showMessage(message: String, title: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
        
    }
    func storeUser(uid: String, name: String , lastName: String, userName: String, email: String){
        let data: [String : Any] = ["name": name, "lastName": lastName,"userName":userName,"email":email]
        getRef.collection("users").document(uid).setData(data, completion: { (error) in
                if let error = error{
                    self.showMessage(message: error.localizedDescription, title: "Alerta")
                    return
                   
                }else{
                    //print("Datos guardados")
                    self.loginBTN.backgroundColor = UIColor.green
                    self.navigationController?.popViewController(animated: true)
                }

        })
    }
    
    
}
