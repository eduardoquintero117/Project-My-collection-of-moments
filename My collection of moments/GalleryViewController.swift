//
//  GalleryViewController.swift
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

class GalleryViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
   
    @IBOutlet weak var galleryPhotos: UICollectionView!
    
    var userID: String!
    var getReff: Firestore!
    var optimizedImage: Data!
    
    var images: [StorageReference] = []
    
    let placeholderImage = UIImage(named:"placeholder")
    
    let storage = Storage.storage()
    var idImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.galleryPhotos!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
                          if user == nil{
                              
                              
                          }else{
                              self.userID = user?.uid
                              
                              //self.getPhotoGallery()
                              self.downloadImage()
                          }
                      }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return images.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        
        
        
        let placeHolder = UIImage(systemName: "photo")

        cell.photoView.sd_setImage(with: images[indexPath.row], placeholderImage: placeHolder)
           cell.photoView.contentMode = .scaleAspectFit
        
           return cell
       }

     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
            
           
             let next = self.storyboard?.instantiateViewController(withIdentifier: "DetailPhotoViewController") as! DetailPhotoViewController
        
        
             next.imagen = cell.photoView.image
             self.present(next, animated: true, completion: nil)
        
        }

    func downloadImage(){
        
        
        //--
           let storageReference = storage.reference().child("/MyCollection").child(userID).child("/photos")
        
           storageReference.listAll { (result, error) in
             if let error = error {
               print(error)
             }
             
             for item in result.items {
               // The items under storageReference.
              
                self.images.append(item)
               
             }
            self.galleryPhotos.reloadData()
            
           }
        
        
        
        
        
    }

    
    
    
}





extension GalleryViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 60, left: 10, bottom: 10, right: 30)
    }
    
    
    
}
