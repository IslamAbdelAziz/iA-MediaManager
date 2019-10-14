//
//  iA-MM.swift
//  iA-MediaManager
//
//  Created by iSlam on 10/14/19.
//  Copyright © 2019 iSlamAbdel-Aziz. All rights reserved.
//  Refrence -> https://medium.com/@deepakrajmurugesan/swift-access-ios-camera-photo-library-video-and-file-from-user-device-6a7fd66beca2

//


import UIKit
import MobileCoreServices
import AVFoundation
import Photos


class MediaManager: NSObject{
    
    static let shared = MediaManager()
    var currentVC: UIViewController?
    
    var imageHandlerBlock: ((UIImage) -> Void)?
    var videoHandlerBlock: ((NSURL) -> Void)?
    var fileHandlerBlock: ((URL) -> Void)?
    
    var AppName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    
    
    func uploadBtnTapped(vc: UIViewController){
        
        currentVC = vc
        
        let alert = UIAlertController(title: MM_Strings.MM_actionSheetTitle.rawValue, message: MM_Strings.MM_actionSheetDescription.rawValue, preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title: MM_Strings.camera.rawValue, style: .default) { (_) in
            self.checkAuthorizationState(iA_MediaTypeEnum: .camera)
        }
        let actionGallary = UIAlertAction(title: MM_Strings.photoLibrary.rawValue, style: .default) { (_) in
            self.checkAuthorizationState(iA_MediaTypeEnum: .photoLibrary)
        }
        
        let actionFile = UIAlertAction(title: MM_Strings.file.rawValue, style: .default) { (_) in
//            self.documentPicker()
            
        }
        let actionCancel = UIAlertAction(title: MM_Strings.cancelBtnTitle.rawValue, style: .cancel) { (_) in
            
        }
        alert.addAction(actionCamera)
        alert.addAction(actionGallary)
        alert.addAction(actionFile)
        alert.addAction(actionCancel)
        currentVC?.present(alert, animated: true, completion: nil)
        
    }
    
    
    func checkAuthorizationState(iA_MediaTypeEnum: iA_MediaType){
        if iA_MediaTypeEnum ==  iA_MediaType.camera{
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            switch status{
            case .authorized: // The user has previously granted access to the camera.
                openCamera()
                
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        self.openCamera()
                    }
                }
                //denied - The user has previously denied access.
            //restricted - The user can't grant access due to restrictions.
            case .denied, .restricted:
                showAccessDeniedAlert()
                return
                
            default:
                break
            }
        }else if iA_MediaTypeEnum == iA_MediaType.photoLibrary || iA_MediaTypeEnum == iA_MediaType.video{
            let status = PHPhotoLibrary.authorizationStatus()
            switch status{
            case .authorized:
                if iA_MediaTypeEnum == iA_MediaType.photoLibrary{
                    photoLibrary()
                }
                
            case .denied, .restricted:
                showAccessDeniedAlert()
                
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (status) in
                    if status == PHAuthorizationStatus.authorized{
                        // photo library access given
                        self.photoLibrary()
                    }
                    if iA_MediaTypeEnum == iA_MediaType.video{
                        self.photoLibrary()
                    }
                })
            default:
                break
            }
        }
    }
    
    
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .camera
                currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .photoLibrary
                currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }

    
    func showAccessDeniedAlert(){
        let alertVC = UIAlertController(title:  "Access Denied", message: "\(AppName ?? "App") \(MM_Strings.MM_accessDenied.rawValue)", preferredStyle: .alert)
        let ok = UIAlertAction(title: MM_Strings.settingsBtnTitle.rawValue, style: .default, handler: { (alertAction) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        })
        let cancel = UIAlertAction(title: MM_Strings.cancelBtnTitle.rawValue, style: .cancel, handler: nil)
        alertVC.addAction(ok)
        alertVC.addAction(cancel)
        currentVC?.present(alertVC, animated: true, completion: nil)
        
    }

}
