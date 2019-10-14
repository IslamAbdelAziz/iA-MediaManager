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
        if let image = info[.originalImage] as? UIImage {
            self.imageHandlerBlock?(image)
        } else{
            print("Something went wrong in  image")
        }
        
        if let videoUrl = info[.mediaURL] as? NSURL{
            print("videourl: ", videoUrl)
            //trying compression of video
            let data = NSData(contentsOf: videoUrl as URL)!
            print("File size before compression: \(Double(data.length / 1048576)) mb")
            self.videoHandlerBlock?(videoUrl)
        }
        else{
            print("Something went wrong in  video")
        }
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension MediaManager: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first{
            self.fileHandlerBlock?(url)
        }
    }
}
