//
//  ForgetPasswordVC.swift
//  Fit Form Fix
//
//  Created by Neha on 23/06/23.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var btnView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnView.layer.cornerRadius = 30
        self.emailTF.layer.cornerRadius = self.emailTF.bounds.height / 2
        self.emailView.addShadowGrey(cornerRadius: 25.0)
        let userIcon1 = UIImage(named: "ic_markunread_24px")
        setLeftViewIcon(image: userIcon1!, textField: self.emailTF)
    }
    

}
//MARK: Buttons
extension ForgetPasswordVC{
    
    @IBAction func backBtn(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueBtn(_ sender: UIButton){
        if emailTF.text!.isEmpty {
            self.view.makeToast("Please fill Email", duration: 1.0, position: .center)
        }else if !(emailTF.text?.validateEmailId(emailTF.text!))!{
            self.view.makeToast("Please fill correct Email Id", duration: 1.0, position: .center)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
//MARK: Functions
extension ForgetPasswordVC{
    func setLeftViewIcon(image: UIImage, textField: UITextField){
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
            imageView.frame = CGRect(x: 15, y: 17, width: 20, height: 18)
            //For Setting extra padding other than Icon.
            let seperatorView = UIView(frame: CGRect(x: 23, y: 0, width: 10, height: 50))

            view.addSubview(seperatorView)
            textField.leftViewMode = .always
            view.addSubview(imageView)
            textField.leftViewMode = UITextField.ViewMode.always
            textField.leftView = view
        }
}
