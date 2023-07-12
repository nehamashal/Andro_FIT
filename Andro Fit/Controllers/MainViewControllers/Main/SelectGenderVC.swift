//
//  SelectGenderVC.swift
//  Fit Form Fix
//
//  Created by Neha on 23/06/23.
//

import UIKit

var orangetheme = UIColor(hexString: "#FFA260")

class SelectGenderVC: UIViewController {

    @IBOutlet weak var  maleView: UIView!
    @IBOutlet weak var  femaleView: UIView!
    
    var gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}

//MARK: Buttons
extension SelectGenderVC{
    
    @IBAction func backBtn(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func maleBtn(_ sender: UIButton){
        gender = "male"
        self.maleView.backgroundColor = orangetheme
        self.femaleView.backgroundColor = UIColor(hexString: "AEAEB2")
    }
    @IBAction func femaleBtn(_ sender: UIButton){
        gender = "female"
        self.maleView.backgroundColor = UIColor(hexString: "AEAEB2")
        self.femaleView.backgroundColor = orangetheme
    }
    @IBAction func continueBtn(_ sender: UIButton){
        if gender == ""{
            self.view.makeToast("Please select your Gender",position: .center)
        }else{
            UserDefaults.standard.set(gender, forKey: "userGender")            
            let storyboard : UIStoryboard = StoryboardConstant.home
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarViewController")
                   window?.rootViewController = mainTabBarController
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
    }
    @IBAction func otherBtn(_ sender: UIButton){
        UserDefaults.standard.set("other", forKey: "userGender")
        
        let storyboard : UIStoryboard = StoryboardConstant.home
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarViewController")
               window?.rootViewController = mainTabBarController
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }

}
