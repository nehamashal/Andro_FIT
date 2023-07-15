//
//  EditProfileVC.swift
//  Andro Fit
//
//  Created by Neha on 14/07/23.
//

import UIKit
import Firebase
import FirebaseStorage

    
class EditProfileVC: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var aboutMe: UITextView!
    
    var ref = DatabaseReference.init()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(openGallery(tapGesture:)))
        myImageView.isUserInteractionEnabled = true
        myImageView.addGestureRecognizer(tapGesture)
        defaultData()
    }
    
    @objc func openGallery(tapGesture: UITapGestureRecognizer){
        self.setUpImagePicker()
    }
}
//MARK: - Buttons
extension EditProfileVC{
    
    @IBAction func saveBtn(_ sender: UIButton){
        self.saveInFirebase()
    }
}

//MARK: - Functions
extension EditProfileVC{
    func saveInFirebase(){
        self.uploadImage(self.myImageView.image!){ url in
            self.saveImage(name: self.fullNameTF.text!, profileURL: url!){ success in
                if success != nil {
                    print("Yes")
                }
            }
        }
    }
    func defaultData(){
        self.fullNameTF.layer.cornerRadius = self.fullNameTF.bounds.height / 2
        self.mailTF.layer.cornerRadius = self.mailTF.bounds.height / 2
        self.passwordTF.layer.cornerRadius = self.passwordTF.bounds.height / 2
        
        self.mailTF.addShadowGrey(cornerRadius: 25.0)
        
        let userIcon1 = UIImage(named: "ic_markunread_24px")
        let passwordIcon = UIImage(named: "passwordLock")
        let personIcon = UIImage(named: "fullName")
        
        setLeftViewIcon(image: userIcon1!, textField: self.mailTF)
        setLeftViewIcon(image: personIcon!, textField: self.fullNameTF)
        setLeftViewIcon(image: passwordIcon!, textField: self.passwordTF)
        
        setRightViewIcon(icon: UIImage(named: "1")!, txtField: passwordTF)
    }
}

//MARK: - Functions
extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func setUpImagePicker(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.isEditing = true
            
            self.present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        myImageView.image = image
        self.dismiss(animated: true)
    }
}

//MARK: - FireBase
extension EditProfileVC {
    
    func uploadImage(_ image: UIImage, completion: @escaping(_ url: URL?) -> ()) {
        let storageRef = Storage.storage().reference().child("profileImg.png")
        let imgData = myImageView.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metaData, error) in
            if error == nil{
                print("Success")
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else{
                print("error in save image")
                completion(nil)
            }
        }
    }
    
    func saveImage(name: String, profileURL: URL, completion: @escaping(_ url: URL?) -> ()) {
        
        let dic = ["name": self.fullNameTF.text!,"gmail": self.mailTF.text!,"password": self.passwordTF.text!,"aboutMe": self.aboutMe.text!,"profileUrl": profileURL.absoluteString] as! [String: Any]
        
        self.ref.child("androFit").childByAutoId().setValue(dic)
    }
}

extension EditProfileVC{
    
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
