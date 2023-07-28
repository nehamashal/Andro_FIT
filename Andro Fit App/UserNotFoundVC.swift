//
//  UserNotFoundVC.swift
//  Andro Fit App
//
//  Created by SMIT iMac27 on 26/07/23.
//

import UIKit

class UserNotFoundVC: UIViewController {
    @IBOutlet weak var mainView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        // Do any additional setup after loading the view.
        //self.mainView.layer.borderColor = UIColor.white.cgColor
    }
    @IBAction func actionBackBtn(_ sender:UIButton){
        self.dismiss(animated: true)
        NotificationCenter.default.post(name: Notification.Name("updatePhotoProcessing"), object: nil)
    }
}
