//
//  PhotoCollectionViewCell.swift
//  My collection of moments
//
//  Created by Eduardo Quintero on 11/04/21.
//  Copyright © 2021 new x. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
   
    var photoView: UIImageView = {
           
           let pv = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 100, height: 100))
           return pv
           
       }()
       override init(frame: CGRect) {
           super.init(frame: frame)
           addSubview(photoView)
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           
       }
    
    
    
    
}
