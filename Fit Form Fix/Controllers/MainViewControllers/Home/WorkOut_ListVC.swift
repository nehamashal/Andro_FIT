//
//  Work_Out_List.swift
//  Gym App
//
//  Created by Neha on 19/06/23.
//

import UIKit


var listExcercise: [String] = ["All","squats","push_up","bench_press", "ic_jumping"]
var nameExcercise: [String] = ["All","Squats","Push-Up","Shoulder Press", "Jumping"]

class WorkOut_ListVC: UIViewController{
    
    @IBOutlet weak var listCollection: UICollectionView!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userName = UserDefaults.standard.string(forKey: "userName") ?? "User Name"
        let categoryIcon = UserDefaults.standard.data(forKey: "profileimg") ?? Data()
        userImg.image = UIImage(data: categoryIcon )
        //findGender()
        listCollection.delegate = self
        listCollection.dataSource = self
        self.nameLbl.text = "Welcome, \(userName)"
        print("profileimg \(categoryIcon)")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
//MARK: Buttons
extension WorkOut_ListVC{
   
}
//MARK: Functions
extension WorkOut_ListVC {
    func findGender(){
        let gender = UserDefaults.standard.string(forKey: "userGender") ?? "other"
        if gender == "male"{
            self.userImg.image = UIImage(named: "male")
        }else if gender == "female"{
            self.userImg.image = UIImage(named: "female")
        }else{
            self.userImg.image = UIImage(named: "other")
        }
    }
}
//MARK: CollectionView
extension WorkOut_ListVC : UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listExcercise.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkOut_ListTVC", for: indexPath) as! WorkOut_ListTVC
        
            let imageName = listExcercise[indexPath.item]
            cell.imageList.image = UIImage(named: imageName)
            cell.nameExc.text = nameExcercise[indexPath.item]
            cell.goBtn.tag = indexPath.item
            cell.goBtn.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
               
        return cell
    }
    @objc private func goButtonTapped(_ sender: UIButton) {
        let selectedIndex = sender.tag
        print("selectedExercise \(selectedIndex)")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            vc.selectedExercise = selectedIndex
        vc.excerciseName = nameExcercise[selectedIndex]
        self.navigationController?.pushViewController(vc, animated: true)        
      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let noOfCellsInRow = 2
                let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20 
                let totalSpace = flowLayout.sectionInset.left
                    + flowLayout.sectionInset.right
                    + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
                let size = Int((listCollection.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
                return CGSize(width: size, height: 200)
        }
}

//MARK: CollectionCell
class WorkOut_ListTVC : UICollectionViewCell{
    
    @IBOutlet weak var imageList:UIImageView!
    @IBOutlet weak var goBtn:UIButton!
    @IBOutlet weak var nameExc:UILabel!
    
    override func awakeFromNib() {
        self.imageList.layer.cornerRadius = 20
        self.imageList.layer.borderWidth = 2
        self.imageList.layer.borderColor = UIColor.white.cgColor
    }
}
