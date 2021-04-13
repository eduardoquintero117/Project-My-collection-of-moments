//
//  AddImagesViewController.swift
//  My collection of moments
//
//  Created by Eduardo Quintero on 11/04/21.
//  Copyright © 2021 new x. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

import FirebaseUI

class AddImagesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var photoIV: UIImageView!

       var userID: String!
       var getReff: Firestore!
       var optimizedImage: Data!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let optimizedImageData = imageSelected.jpegData(compressionQuality: 0.6){
            photoIV.image = imageSelected
            optimizedImage =  optimizedImageData
            
            
        }
        dismiss(animated: true, completion: nil)
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
                if let error = error {
                    print("error", error.localizedDescription)
                    
                }else{
                    
                      print(storageMetaData?.path)
                }
            }
        }
    
    
    
    
    
    
    
    
    @IBAction func addImageBTN(_ sender: UIButton) {
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
