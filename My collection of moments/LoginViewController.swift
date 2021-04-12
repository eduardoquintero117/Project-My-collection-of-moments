//
//  LoginViewController.swift
//  My collection of moments
//
//  Created by Eduardo Quintero on 11/04/21.
//  Copyright © 2021 new x. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {


    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginBTN(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "menu")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
        
        
        guard let email = emailTF.text, email !=  "" , let password = passwordTF.text,  password != "" else {
                   return
               }
        
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                //print("Usuario autentificado")
                
                 //self.performSegue(withIdentifier: "menu", sender: MyPicturesViewController.self)
            }
        }
        
    }
    

}
