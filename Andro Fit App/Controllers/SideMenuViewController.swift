//
//  SideMenuViewController.swift
//  Andro Fit App
//
//  Created by Rajni Bajaj on 20/07/23.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var sideMenyTV:UITableView!
    var optionArr = ["History", "Logout"]
    var optionIcon = ["History","logout"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sideMenyTV.delegate = self
        self.sideMenyTV.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.sideMenyTV.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        cell.optionname.text = optionArr[indexPath.row]
        cell.icon.image = UIImage(named: optionIcon[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // History
            let vc = storyboard?.instantiateViewController(withIdentifier: "RecordOfExerciseVC") as! RecordOfExerciseVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            // logout
            logoutPerform()
        }
    }
    func logoutPerform(){
        UserDefaults.standard.removeObject(forKey: "userGender")
           UserDefaults.standard.removeObject(forKey: "imagePath")
           UserDefaults.standard.removeObject(forKey: "isLoggedIn")
       //    UserDefaults.standard.removeObject(forKey: "userName")
       //    UserDefaults.standard.removeObject(forKey: "profileimg")
           UserDefaults.standard.removeObject(forKey: "Array")
           UserDefaults.standard.removeObject(forKey: "squat_Count")
           UserDefaults.standard.removeObject(forKey: "shoulderPressCount")
           UserDefaults.standard.removeObject(forKey: "pushUp_Count")
           changeIntialController()
    }
    func changeIntialController(){
        
        let storyboard : UIStoryboard = StoryboardConstant.main
        let loginNavController = storyboard.instantiateViewController(identifier: "WelcomeNavVC")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
}
class SideMenuCell:UITableViewCell{
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var optionname:UILabel!
}
