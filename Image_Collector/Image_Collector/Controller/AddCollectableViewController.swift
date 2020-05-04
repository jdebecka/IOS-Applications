//
//  AddCollectableViewController.swift
//  Image_Collector
//
//  Created by Julia Debecka on 03/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class AddCollectableViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var pickerController = UIImagePickerController()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCollectable(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let collactable = Collactable(context: context)
            
            collactable.title = self.textField.text
            collactable.image = self.imageView.image?.jpegData(compressionQuality: 0.6)
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mediaFolderTapped(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
}

extension AddCollectableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
