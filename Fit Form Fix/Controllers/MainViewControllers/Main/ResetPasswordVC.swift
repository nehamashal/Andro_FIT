//
//  ResetPasswordVC.swift
//  Fit Form Fix
//
//  Created by Neha on 23/06/23.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPwdTF: UITextField!
    @IBOutlet weak var newPwdView: UIView!
    @IBOutlet weak var confirmPwdView: UIView!
    @IBOutlet weak var btnView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnView.layer.cornerRadius = 30
        self.passwordTF.layer.cornerRadius = self.passwordTF.bounds.height / 2
        self.confirmPwdTF.layer.cornerRadius = self.confirmPwdTF.bounds.height / 2
        
        self.newPwdView.addShadowGrey(cornerRadius: 25.0)
        self.confirmPwdView.addShadowGrey(cornerRadius: 25.0)
        let userIcon1 = UIImage(named: "ic_markunread_24px")
        let passwordIcon = UIImage(named: "passwordLock")
        let personIcon = UIImage(named: "fullName")
        setLeftViewIcon(image: passwordIcon!, textField: self.passwordTF)
        setLeftViewIcon(image: passwordIcon!, textField: self.confirmPwdTF)
        
        setRightViewIcon(icon: UIImage(named: "1")!, txtField: confirmPwdTF)
        setRightViewIcon(icon: UIImage(named: "1")!, txtField: passwordTF)
    }
    
}

//MARK: Buttons
extension ResetPasswordVC{
    
    @IBAction func backBtn(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueBtn(_ sender: UIButton){
        if passwordTF.text!.isEmpty {
             self.view.makeToast("Please fill password", duration: 1.0, position: .center)
            
        }
        else if passwordTF.text!.count < 6{
                self.view.makeToast("Please enter password of minimum 6 Character", duration: 1, position:.center)
        }else if confirmPwdTF.text!.isEmpty {
                self.view.makeToast("Please fill Confirm Password",position: .center)
        }else if passwordTF.text != confirmPwdTF.text {
                self.view.makeToast("Password and Confirm Password donot match",position: .center)
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
//MARK: Functions
extension ResetPasswordVC{
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
          if txtField == confirmPwdTF{
              btnView.addTarget(self, action: #selector(self.showConfirmButtonTapped), for: .touchUpInside)
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
      @objc func showConfirmButtonTapped(_ sender: UIButton) {
                  sender.isSelected = !sender.isSelected
                  if sender.isSelected{
                      sender.setImage(UIImage(named: "2"), for: .normal)
                      confirmPwdTF.isSecureTextEntry=false
                  }
                  else {
                      sender.setImage(UIImage(named: "1"), for: .normal)
                      confirmPwdTF.isSecureTextEntry=true
                  }
      }
     
}
