//
//  SettingVC.swift
//  Andro Fit
//
//  Created by Neha on 07/07/23.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var logoutView:UIView!
    @IBOutlet weak var settingsTV: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    var settingsText = ["- Edit Profile", "- My Fitness Data", "- Workout Options", "- Invite a friend"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.findNameAndGender()
        self.settingsTV.delegate = self
        self.settingsTV.dataSource = self
    }
    
    @IBAction func backBtn(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
extension SettingVC{
    @IBAction func logoutBtn(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "userGender")
        UserDefaults.standard.removeObject(forKey: "imagePath")
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        changeIntialController()
    }
}
//MARK: Functions
extension SettingVC {
    
    func changeIntialController(){
        
        let storyboard : UIStoryboard = StoryboardConstant.main
        let loginNavController = storyboard.instantiateViewController(identifier: "WelcomeNavVC")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
    func findNameAndGender(){
        let gender = UserDefaults.standard.string(forKey: "userGender") ?? "other"
        let name = UserDefaults.standard.string(forKey: "userName")
        self.nameLbl.text = name
        
        if gender == "male"{
            self.userImg.image = UIImage(named: "male")
        }else if gender == "female"{
            self.userImg.image = UIImage(named: "female")
        }else{
            self.userImg.image = UIImage(named: "other")
        }
        
        logoutView.simpleWhiteShadow()
    }
}

// TableView
extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTV.dequeueReusableCell(withIdentifier: "SettingTVC", for: indexPath) as! SettingTVC
        cell.settingsName.text = settingsText[indexPath.row]
        return cell
    }
}

// MARK: TableViewCell
class SettingTVC: UITableViewCell {
    @IBOutlet weak var settingsName:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
