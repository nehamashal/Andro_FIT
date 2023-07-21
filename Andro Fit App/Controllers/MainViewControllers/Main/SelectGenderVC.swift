//
//  SelectGenderVC.swift
//  Fit Form Fix
//
//  Created by Neha on 23/06/23.
//

import UIKit

var orangetheme = UIColor(hexString: "#4e2cde")
var liteOrange = UIColor(hexString: "#f2c0a2")
var grayBG = UIColor(hexString: "#8E8E93")

class SelectGenderVC: UIViewController {

    @IBOutlet weak var genderImgCV: UICollectionView!
    var gender = ""
    var genderImg = ["Man","Woman"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderImgCV.delegate = self
        genderImgCV.dataSource = self
    }
    

}

//MARK: Buttons
extension SelectGenderVC{
    
    @IBAction func backBtn(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueBtn(_ sender: UIButton){
        if gender == ""{
            self.view.makeToast("Please select your Gender",position: .center)
        }else{
            UserDefaults.standard.set("1", forKey: "isLoggedIn")
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

//MARK: CollectionViewCell

extension SelectGenderVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genderImgCV.dequeueReusableCell(withReuseIdentifier: "genderImgCVC", for: indexPath) as! genderImgCVC
        let img = genderImg[indexPath.row]
        cell.genderImg.image = UIImage(named: img)
        cell.selectBtnView.tag = indexPath.row
        cell.selectBtnView.addTarget(self, action: #selector(actionSelectPhoto), for: .touchUpInside)
        return cell
    }
    
    @objc func actionSelectPhoto(_ sender: UIButton) {
        print("indexPath will be \(sender.tag)")
        let index = sender.tag
        let indexPath = IndexPath(row: index, section: 0)
        
        if let selectedCell = genderImgCV.cellForItem(at: indexPath) as? genderImgCVC {
            if index == 0 {
                selectedCell.mainView.backgroundColor = liteOrange
                gender = "male"
            } else if index == 1 {
                selectedCell.mainView.backgroundColor = liteOrange
                gender = "female"
            }
        }
        
        // Reset background color for other cells
        for cell in genderImgCV.visibleCells {
            if let otherCell = cell as? genderImgCVC, let otherIndexPath = genderImgCV.indexPath(for: otherCell) {
                if otherIndexPath != indexPath {
                    otherCell.mainView.backgroundColor = grayBG
                }
            }
        }
    }


  
    
}

class genderImgCVC: UICollectionViewCell{
    
    @IBOutlet weak var  mainView: UIView!
    @IBOutlet weak var selectBtnView: UIButton!
    @IBOutlet weak var genderImg: UIImageView!
    
}
