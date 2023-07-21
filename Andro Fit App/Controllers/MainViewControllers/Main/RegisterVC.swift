//
//  RegisterVC.swift
//  Gym App
//
//  Created by Neha on 20/06/23.
//

import UIKit

class RegisterVC: UIViewController {
    @IBOutlet weak var fullNameTF:UITextField!
    @IBOutlet weak var emailTF:UITextField!
    @IBOutlet weak var passwordTF:UITextField!
    @IBOutlet weak var btnView: UIView!
//    @IBOutlet weak var confirmPwd:UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var fullNameView:UIView!
    @IBOutlet weak var emailView:UIView!
    @IBOutlet weak var passwordView:UIView!
//    @IBOutlet weak var confirmPwdView:UIView!
    
    @IBOutlet weak var signIn:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnView.layer.cornerRadius = 30
        self.fullNameTF.layer.cornerRadius = self.fullNameTF.bounds.height / 2
        self.emailTF.layer.cornerRadius = self.emailTF.bounds.height / 2
        self.passwordTF.layer.cornerRadius = self.passwordTF.bounds.height / 2
//        self.confirmPwd.layer.cornerRadius = self.confirmPwd.bounds.height / 2
        
        self.fullNameView.addShadowGrey(cornerRadius: 25.0)
        self.emailView.addShadowGrey(cornerRadius: 25.0)
        self.passwordView.addShadowGrey(cornerRadius: 25.0)
//        self.confirmPwdView.addShadowGrey(cornerRadius: 25.0)
        
        let userIcon1 = UIImage(named: "mail")
        let passwordIcon = UIImage(named: "Call")
        let personIcon = UIImage(named: "fullName")
        
        setLeftViewIcon(image: userIcon1!, textField: self.emailTF)
        setLeftViewIcon(image: personIcon!, textField: self.fullNameTF)
        setLeftViewIcon(image: passwordIcon!, textField: self.passwordTF)
//        setLeftViewIcon(image: passwordIcon!, textField: self.confirmPwd)
        
//        setRightViewIcon(icon: UIImage(named: "1")!, txtField: confirmPwd)
//        setRightViewIcon(icon: UIImage(named: "1")!, txtField: passwordTF)
        
//        self.fullNameTF.text = "ABC"
//        self.emailTF.text = "abc@yopmail.com"
//        self.passwordTF.text = "123456"
//        self.confirmPwd.text = "123456"
    }
    
     
}
extension RegisterVC{
    @IBAction func actionCountinue(_ sender:UIButton){
        if fullNameTF.text!.isEmpty {
            self.view.makeToast("Please fill your name",position: .center)
        }else if emailTF.text!.isEmpty {
            self.view.makeToast("Please fill Email", duration: 1.0, position: .center)
        }else if !(emailTF.text?.validateEmailId(emailTF.text!))!{
           self.view.makeToast("Please fill correct Email Id", duration: 1.0, position: .center)
        }
        else if passwordTF.text!.isEmpty {
             self.view.makeToast("Please fill Phone Number", duration: 1.0, position: .center)
            
        }
        else if passwordTF.text!.count < 10 {
                self.view.makeToast("Please enter Valid Phone Number", duration: 1, position:.center)
//        }else if confirmPwd.text!.isEmpty {
//                self.view.makeToast("Please fill Confirm Password",position: .center)
//        }else if passwordTF.text != confirmPwd.text {
//                self.view.makeToast("Password and Confirm Password donot match",position: .center)
        }else {
            UserDefaults.standard.set(self.fullNameTF.text, forKey: "userName")
            let vc = storyboard?.instantiateViewController(identifier: "ScanFaceVC") as! ScanFaceVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func loginBtn(_ sender:UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "LogInVC") as! LogInVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
    @IBAction func editButton(_ sender:UIButton){
        ImagePickerManager().pickImage(self){ image in
            self.userImg.image = image
            
           }
    }
    
}
extension RegisterVC{
    
    func setLeftViewIcon(image: UIImage, textField: UITextField){
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
        imageView.frame = CGRect(x: 15, y: 17, width: 20, height: 20)
        //For Setting extra padding other than Icon.
        let seperatorView = UIView(frame: CGRect(x: 23, y: 0, width: 10, height: 50))
        
        view.addSubview(seperatorView)
        textField.leftViewMode = .always
        view.addSubview(imageView)
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = view
    }
    func setRightViewIcon(icon: UIImage , txtField : UITextField) {
        
        let btnView = UIButton(frame: CGRect(x: 0, y: 0, width:80, height: 80))
        btnView.setImage(icon, for: .normal)
        btnView.imageEdgeInsets = UIEdgeInsets(top: -10, left: -36, bottom: -10, right:  10)
        btnView.imageView?.contentMode = .scaleAspectFit
        if txtField == passwordTF{
            btnView.addTarget(self, action: #selector(self.showButtonTapped), for: .touchUpInside)
        }
//        if txtField == confirmPwd{
//            btnView.addTarget(self, action: #selector(self.showConfirmButtonTapped), for: .touchUpInside)
//        }
        
        
        txtField.rightViewMode = .always
        txtField.rightView = btnView
    }
    @objc func showButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sender.setImage(UIImage(named: "2"), for: .normal)
            passwordTF.isSecureTextEntry=false
        }
        else {
            sender.setImage(UIImage(named: "1"), for: .normal)
            passwordTF.isSecureTextEntry=true
        }
    }
    @objc func showConfirmButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sender.setImage(UIImage(named: "2"), for: .normal)
//            confirmPwd.isSecureTextEntry=false
        }
        else {
            sender.setImage(UIImage(named: "1"), for: .normal)
//            confirmPwd.isSecureTextEntry=true
        }
    }
    
    
    
}


