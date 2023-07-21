//
//  ImageInFullScreenVC.swift
//  Andro Fit
//
//  Created by Neha on 14/07/23.
//

import UIKit

class ImageInFullScreenVC: UIViewController {
    
    @IBOutlet weak var fullUserImg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let categoryIcon = UserDefaults.standard.data(forKey: "profileimg") ?? Data()
        fullUserImg.image = UIImage(data: categoryIcon )
    }
    
    @IBAction func backToSettings(_ sender:UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

