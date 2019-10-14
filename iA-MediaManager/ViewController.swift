//
//  ViewController.swift
//  iA-MediaManager
//
//  Created by iSlam on 10/14/19.
//  Copyright © 2019 iSlamAbdel-Aziz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addBtnTapped(){
        MediaManager.shared.addMedia(vc: self)
        MediaManager.shared.imageHandlerBlock = { (image) in
            self.imgView.image = image
        }
    }

}

