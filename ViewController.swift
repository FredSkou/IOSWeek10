//
//  ViewController.swift
//  IOSWeek10
//
//  Created by admin on 15/06/2020.
//  Copyright © 2020 Fred. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

class ViewController: UIViewController {
        
    @IBOutlet weak var downloadImage: UIImageView!
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var downloadName: UITextField!
    @IBOutlet weak var uploadName: UITextField!
    
    @IBAction func downloadImageFromDB(_ sender: Any) {
        let downloadImageName = downloadName.text
        // database info, i could for sure make it so that its global and i dont have to write it multiple times. Ill Try that next time.
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let downloadImageRef = storageRef.child(downloadImageName!)
        let downloadTast = downloadImageRef.getData(maxSize: 1*1024*1024){
            data,error in
            if let error = error{
                print("ERROR Downloading Image!\(downloadImageName)")
            }else{
                print("Image \(downloadImageName) has been Downloaded!")
                // You make a let with the data and then put tat data in the ImageViews.
                let downloadedImage = UIImage(data: data!)
                self.downloadImage.image = downloadedImage
                self.uploadImage.image = downloadedImage
            }
        }
        
    }
    @IBAction func uploadImageToDB(_ sender: Any) {
        
        let uploadImageName = uploadName.text
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let uploadImageRef = storageRef.child(uploadImageName!)
        guard let uploadimage = uploadImage.image else{return}
        guard let imageData = uploadimage.jpegData(compressionQuality: 1) else{return}
        let uploadTask = uploadImageRef.putData(imageData,metadata: nil){(metadata,error) in
        print("Image \(uploadImageName) Uploaded!")
        print(metadata ?? "No MetaData!")
        print(error ?? "NO errors!)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // This could be in AppDelegate
        FirebaseApp.configure()
    }
}
