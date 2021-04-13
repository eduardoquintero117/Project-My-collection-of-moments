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
    @IBOutlet weak var photoIV: UIImageView!
    
    
    var userID: String!
    var getReff: Firestore!
    var optimizedImage: Data!
    var photoImageView: UIImageView!
    var state: Bool!
    
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
                       //self.emailLB.text = user?.email
                       self.getName()
                       self.getPhoto()
                       
                   }
               }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let optimizedImageData = imageSelected.jpegData(compressionQuality: 0.6){
            
            optimizedImage =  optimizedImageData
            
            if (state){
                userPhotoIV.image =  imageSelected
                saveImageUser(optimizedImage)
                optimizedImage = nil
                
            }else{
                photoIV.image = imageSelected
                
            }
        }
        dismiss(animated: true, completion: nil)
    }
    //---
    
    
    func getPhoto(){
        
        let storageReference = Storage.storage().reference().child("/MyCollection").child(userID).child("/userPhoto")
               
                  storageReference.listAll { (result, error) in
                    if let error = error {
                        print(error)
                    }
                    
                    for item in result.items {
                      
                        let placeHolder = UIImage(systemName: "person.fill")
                        self.userPhotoIV.sd_setImage(with: item, placeholderImage: placeHolder)
                    }
                   
                   
                  }
        
        

    }

    
    func getName() {
        
        let result = Firestore.firestore().collection("users").document(userID)
        result.getDocument { (snapshot, error) in
            let userName = snapshot?.get("userName") as? String ?? "sin valor"
            let email = snapshot?.get("email") as? String ?? "sin valor"
            
            self.userNameLB.text = userName
            self.emailLB.text = email
            
        }
    }
    
    
    func saveImageUser(_ imageData: Data) {
        
            //--activity
            let activityIndicator = UIActivityIndicatorView.init(style: .large)
            activityIndicator.color = .red
            activityIndicator.center = view.center
            activityIndicator.center = userPhotoIV.center
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
            //--
        
        
            let storageReference = Storage.storage().reference()
            let userImageRef = storageReference.child("/MyCollection").child(userID).child("/userPhoto").child("/userPhoto")
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
        
    
    func saveImage(_ imageData: Data) {
           
               //----activity
               let activityIndicator = UIActivityIndicatorView.init(style: .large)
               activityIndicator.color = .red
               activityIndicator.center = view.center
               activityIndicator.center = photoIV.center
               activityIndicator.startAnimating()
               view.addSubview(activityIndicator)
               //----
           
               //--Date
               let date = Date()
               let dateFormatter = DateFormatter()
               dateFormatter.dateStyle = .medium
               let dateString = dateFormatter.string(from: date)
               let timeFormatter = DateFormatter()
               timeFormatter.timeStyle = .medium
               let timeString = timeFormatter.string(from: date)
               let dateAndTime = "-" + dateString + "-" + timeString
               //print(dateAndTime)
               //---
               let storageReference = Storage.storage().reference()
               
               let userImageRef = storageReference.child("/MyCollection").child(userID).child("/photos").child("photo\(dateAndTime)")
               let uploadMetada = StorageMetadata()
               
               uploadMetada.contentType = "image/jpeg"
               
               userImageRef.putData(imageData, metadata: uploadMetada) { (storageMetaData, error) in
                   
                   activityIndicator.stopAnimating()
                   activityIndicator.removeFromSuperview()
                
                   
                self.photoIV.image = nil
                
                
                   if let error = error {
                       print("error", error.localizedDescription)
                       
                   }else{
                       
                         print(storageMetaData?.path)
                   }
               }
           }
    
    
    
    
    
    
    @IBAction func cameraBTN(_ sender: UIButton) {
        
        state = true
        let photoImage = UIImagePickerController()
        photoImage.sourceType = UIImagePickerController.SourceType.photoLibrary
        photoImage.delegate = self
        present(photoImage, animated: true )
        
        
        }
        
        @IBAction func addImageBTN(_ sender: UIButton) {
           state = false
           let photoImage = UIImagePickerController()
                  photoImage.sourceType = UIImagePickerController.SourceType.photoLibrary
                  photoImage.delegate = self
                  present(photoImage, animated: true )
       }
        
      @IBAction func uploadBTN(_ sender: UIButton) {
           if (optimizedImage != nil){
               Auth.auth().addStateDidChangeListener { (auth, user) in
                   if user == nil{
                       
                       
                   }else{
                       self.userID = user?.uid
                       self.saveImage(self.optimizedImage)
                   
                       
                   }
               }
           }
           
           
       }
       
       
        
        
    
    
    

    
    
}





extension UIImageView {

    func makeRounded() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

