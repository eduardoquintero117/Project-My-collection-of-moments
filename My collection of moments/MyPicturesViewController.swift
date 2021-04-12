//
//  MyPicturesViewController.swift
//  My collection of moments
//
//  Created by Eduardo Quintero on 11/04/21.
//  Copyright © 2021 new x. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import MobileCoreServices
import FirebaseUI


class MyPicturesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userPhotoIV: UIImageView!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var emailLB: UILabel!
    @IBOutlet weak var photosCV: UICollectionView!
    
    var userID: String!
    var getReff: Firestore!
    var optimizedImage: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.isNavigationBarHidden = true
        userPhotoIV.makeRounded()
        userPhotoIV.contentMode = .scaleAspectFill
        //userPhotoIV.layer.transform = CATransform3DMakeScale(2, 2, 2)
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
                   if user == nil{
                       
                       
                   }else{
                       self.userID = user?.uid
                       self.emailLB.text = user?.email
                       self.getName()
                       self.getPhoto()
                       
                   }
               }
    }
    
    @IBAction func cameraBTN(_ sender: UIButton) {
        let photoImage = UIImagePickerController()
        photoImage.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        photoImage.delegate = self
        present(photoImage, animated: true )
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let optimizedImageData = imageSelected.jpegData(compressionQuality: 0.6){
            userPhotoIV.image = imageSelected
            optimizedImage =  optimizedImageData
            
            self.saveImage(optimizedImageData)
        }
        dismiss(animated: true, completion: nil)
    }

    func getPhoto(){
        
        let storageReference = Storage.storage().reference()
               let placeHolder = UIImage(systemName: "person.fill")
               let userImageRef = storageReference.child("/photos").child(userID)
               
               userImageRef.downloadURL { (url, error) in
                   if let error = error{
                       print(error.localizedDescription)
                   }else{
                    print("Imagen descargada",url)
                   }
                
               }
        userPhotoIV.sd_setImage(with: userImageRef, placeholderImage: placeHolder)
    }

    
    func getName() {
        print(userID)
        print("-----------------")
        //Firestore.firestore
        let result = Firestore.firestore().collection("users").document(userID)
        result.getDocument { (snapshot, error) in
            let userName = snapshot?.get("userName") as? String ?? "sin valor"
            let email = snapshot?.get("email") as? String ?? "sin valor"
            
            self.userNameLB.text = userName
            self.emailLB.text = email
            
        }
    }
    
    
    func saveImage(_ imageData: Data) {
            let activityIndicator = UIActivityIndicatorView.init(style: .large)
            activityIndicator.color = .red
            activityIndicator.center = view.center
            activityIndicator.center = userPhotoIV.center
            
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
            
            let storageReference = Storage.storage().reference()
            let userImageRef = storageReference.child("/photos").child(userID)
            let uploadMetada = StorageMetadata()
            
            uploadMetada.contentType = "image/jpeg"
            
            userImageRef.putData(imageData, metadata: uploadMetada) { (storageMetaData, error) in
                
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                if let error = error {
                    print("error", error.localizedDescription)
                    
                }else{
                    
                      print(storageMetaData?.path)
                }
            }
        }
        
    

    
    
}





extension UIImageView {

    func makeRounded() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        //self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
