//
//  GalleryViewController.swift
//  My collection of moments
//
//  Created by Eduardo Quintero on 11/04/21.
//  Copyright © 2021 new x. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
   
    @IBOutlet weak var galleryPhotos: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.galleryPhotos!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 10
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
           return cell
       }

    

}


