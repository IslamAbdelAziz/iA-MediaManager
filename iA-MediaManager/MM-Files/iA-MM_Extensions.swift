//
//  iA-MM_Extensions.swift
//  iA-MediaManager
//
//  Created by iSlam on 10/14/19.
//  Copyright © 2019 iSlamAbdel-Aziz. All rights reserved.
//

import UIKit


extension MediaManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        currentVC?.dismiss(animated: true) {
            if let photo = info[.originalImage] as? UIImage{
                self.imageHandlerBlock?(photo)
            }
        }
    }
    
    
    
}

