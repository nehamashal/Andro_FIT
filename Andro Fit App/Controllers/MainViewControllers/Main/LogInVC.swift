//
//  LogInVC.swift
//  Fit Form Fix
//
//  Created by Neha on 23/06/23.
//

import UIKit
import AVFoundation

class LogInVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var lblUnderLine: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        self.btnView.layer.cornerRadius = 30
        self.emailTF.layer.cornerRadius = self.emailTF.bounds.height / 2
        self.passwordTF.layer.cornerRadius = self.passwordTF.bounds.height / 2
        
        self.emailView.addShadowGrey(cornerRadius: 25.0)
        self.passwordView.addShadowGrey(cornerRadius: 25.0)
        let userIcon1 = UIImage(named: "mail")
        let passwordIcon = UIImage(named: "passwordLock")
        let personIcon = UIImage(named: "fullName")
        setLeftViewIcon(image: userIcon1!, textField: self.emailTF)
        setLeftViewIcon(image: passwordIcon!, textField: self.passwordTF)
        
        setRightViewIcon(icon: UIImage(named: "1")!, txtField: passwordTF)
    
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "SIGN UP", attributes: underlineAttribute)
        lblUnderLine.attributedText = underlineAttributedString
        
//        self.emailTF.text = "abc@yopmail.com"
//        self.passwordTF.text = "123456"
    }

}
//MARK: Buttons
extension LogInVC{
    
    @IBAction func backBtn(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func loginBtn(_ sender: UIButton){
        if emailTF.text!.isEmpty {
            self.view.makeToast("Please fill Email", duration: 1.0, position: .center)
        }else if !(emailTF.text?.validateEmailId(emailTF.text!))!{
            self.view.makeToast("Please fill correct Email Id", duration: 1.0, position: .center)
        }
        else if passwordTF.text!.isEmpty {
            self.view.makeToast("Please fill password", duration: 1.0, position: .center)
            
        }
        else if passwordTF.text!.count < 6{
            self.view.makeToast("Please enter password of minimum 6 Character", duration: 1, position:.center)
        }else {
            UserDefaults.standard.set("1", forKey: "isLoggedIn")
            
            let storyboard : UIStoryboard = StoryboardConstant.home
            let mainTabBarController = storyboard.instantiateViewController(identifier: "HomeMainNAV")
                   window?.rootViewController = mainTabBarController
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)

            
        }
    }
    @IBAction func forgetPwdBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func registerBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
            self.navigationController?.pushViewController(vc, animated: true)         
    }
    

}
//MARK: Functions
extension LogInVC{
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
    func setRightViewIcon(icon: UIImage , txtField : UITextField) {

          let btnView = UIButton(frame: CGRect(x: 0, y: 0, width:80, height: 80))
          btnView.setImage(icon, for: .normal)
          btnView.imageEdgeInsets = UIEdgeInsets(top: -10, left: -36, bottom: -10, right:  10)
          btnView.imageView?.contentMode = .scaleAspectFit
          if txtField == passwordTF{
              btnView.addTarget(self, action: #selector(self.showButtonTapped), for: .touchUpInside)
          }
         
          
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
     
}
