//
//  WelcomeVC.swift
//  Gym App
//
//  Created by Neha on 20/06/23.
//

import UIKit


class WelcomeVC: UIViewController {

    @IBOutlet weak var btnView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnView.layer.cornerRadius = 30
        
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {

    }
    @IBAction func login(_ sender:UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
