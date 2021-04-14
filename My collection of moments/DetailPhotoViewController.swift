//
//  DetailPhotoViewController.swift
//  My collection of moments
//
//  Created by Eduardo Quintero on 13/04/21.
//  Copyright © 2021 new x. All rights reserved.
//



import UIKit

class DetailPhotoViewController : UIViewController{

    var imagen: UIImage!
    var imageScrollView: ImageScrollView!

    let saveButtton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Descarga Imagen", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        b.backgroundColor = UIColor.systemBlue
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(savePhoto), for: .touchUpInside)
        return b
       }()

    override func viewDidLoad() {
        super .viewDidLoad()
        
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        setupImageScrollView()

        let image = imagen!
        self.imageScrollView.set(image: image)
        
        view.addSubview(saveButtton)

              //saveButtton.center = view.center

        view.backgroundColor = .white
               //saveButtton.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 10).isActive = true
                //saveButtton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
                 //saveButtton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        saveButtton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButtton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        saveButtton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        saveButtton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
                     

    }
    @objc func savePhoto(){
        print("save")
        guard let imageN = imagen else {return}

       UIImageWriteToSavedPhotosAlbum(imageN, nil, #selector(newImage(_:didFinichSavingWithError:contextInfo:)), nil)
    }

    @objc func newImage(_ image: UIImage, didFinichSavingWithError error: Error? , contextInfo: UnsafeRawPointer){



       }

  func setupImageScrollView() {
      imageScrollView.translatesAutoresizingMaskIntoConstraints = false
      imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
      imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
  }

}


