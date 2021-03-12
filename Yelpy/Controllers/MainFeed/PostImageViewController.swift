//
//  PostImageViewController.swift
//  Yelpy
//
//  Created by Richard Pham on 3/11/21.
//  Copyright © 2021 memo. All rights reserved.
//

import UIKit
// MARK: LAB 6 TODO: Create Protocol for PostImageViewControllerDelegate
protocol PostImageViewControllerDelegate: class {
  func imageSelected(controller: PostImageViewController, image: UIImage)
}


class PostImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedImageView: UIImageView!
    // MARK: LAB 6 TODO: Add delegate for the protocol you created
    weak var delegate: PostImageViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createImagePicker()
        navigationController?.navigationBar.isHidden = true
    }
    

    @IBAction func onFinishPosting(_ sender: Any) {
        performSegue(withIdentifier: "unwindToDetail", sender: self)
            // MARK: LAB 6 TODO: Pass image through protocol method
            delegate.imageSelected(controller: self, image: self.selectedImageView.image!)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: LAB 6 TODO: ImagePicker Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[.originalImage] as! UIImage

        self.selectedImageView.image = originalImage
        
        dismiss(animated: true, completion: nil)
    }

    
    // MARK: Create Image Picker
    func createImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            imagePicker.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            imagePicker.sourceType = .photoLibrary
        }
        self.present(imagePicker, animated: true, completion: nil)
    }

}
