//
//  SideMenuViewController.swift
//  Andro Fit App
//
//  Created by Neha on 20/07/23.
//

import UIKit

class SideMenuViewController: UIViewController{   
    
    @IBOutlet weak var sideMenyTV:UITableView!
    
    var optionArr = ["About Us", "Contact Us", "Today's  Workout", "History", "Settings"]
    var optionIcon = ["AboutUS","ContactUS","Timmer","Timmer","Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenyTV.delegate = self
        self.sideMenyTV.dataSource = self
    }
    
}

//Buttons
extension SideMenuViewController {

}

//Functions
extension SideMenuViewController {
    func logoutPerform(){
        UserDefaults.standard.removeObject(forKey: "imagePath")
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "profileimg")
        UserDefaults.standard.removeObject(forKey: "Array")
        UserDefaults.standard.removeObject(forKey: "squat_Count")
        UserDefaults.standard.removeObject(forKey: "shoulderPressCount")
        UserDefaults.standard.removeObject(forKey: "pushUp_Count")
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// TableView
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource  {
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
            // about us
        }else if indexPath.row == 1 {
            // contact us
            logoutPerform()
        }else if indexPath.row == 2 {
            // today's workout
            let vc = storyboard?.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
            vc.screenName = "Today"
            self.navigationController?.pushViewController(vc, animated: true)
            logoutPerform()
        }else if indexPath.row == 3 {
            // History
            let vc = storyboard?.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
            vc.screenName = "History"
            self.navigationController?.pushViewController(vc, animated: true)
            logoutPerform()
        }else if indexPath.row == 4 {
            // settings
            logoutPerform()
        }
    }
    
}



//MARK: UITableViewCell
class SideMenuCell:UITableViewCell{
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var optionname:UILabel!
}
