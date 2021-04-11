//
//  MyPicturesViewController.swift
//  My collection of moments
//
//  Created by Eduardo Quintero on 11/04/21.
//  Copyright © 2021 new x. All rights reserved.
//

import UIKit

class MyPicturesViewController: UIViewController {
    
    @IBOutlet weak var userPhotoIV: UIImageView!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var emailLB: UILabel!
    @IBOutlet weak var photosCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraBTN(_ sender: UIButton) {
    }
    

}
