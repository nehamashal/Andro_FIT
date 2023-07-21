//
//  HomeViewController.swift
//  Andro Fit App
//
//  Created by Neha on 18/07/23.
//

import UIKit

import AVFoundation



var workoutName:[String] = ["My Workout \nExercise","Exercise of \nThe Day"]
var workoutImg:[String] = ["MyWorkOut","ExcerciseOfTheDay"]

class HomeViewController: UIViewController {

    @IBOutlet weak var workoutCollectionView: UICollectionView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var emailLbl:UILabel!
    
    let ASWIoTDataManager = "MyIotDataManager"
   
    var matchedString: String?
    //AVCapture Configure
    var captureSession: AVCaptureSession!
    var imgOutPut: AVCapturePhotoOutput!
    var vdoPreviewLayer: AVCaptureVideoPreviewLayer!
    
//    var plateNumberDetails : ApiLoginResponseModel?
    var driverFaceUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = UserDefaults.standard.string(forKey: "userName") ?? "User Name"
        let categoryIcon = UserDefaults.standard.data(forKey: "profileimg") ?? Data()
        userImg.image = UIImage(data: categoryIcon )
        self.nameLbl.text = "\(userName)"
        
        self.workoutCollectionView.delegate = self
        self.workoutCollectionView.dataSource = self
        
    }
    
}
//Buttons
extension HomeViewController {
    @IBAction func navButton(_ sender:UIButton){
    UserDefaults.standard.removeObject(forKey: "userGender")
    UserDefaults.standard.removeObject(forKey: "imagePath")
    UserDefaults.standard.removeObject(forKey: "isLoggedIn")
    UserDefaults.standard.removeObject(forKey: "Array")
    UserDefaults.standard.removeObject(forKey: "squat_Count")
    UserDefaults.standard.removeObject(forKey: "shoulderPressCount")
    UserDefaults.standard.removeObject(forKey: "pushUp_Count")
    changeIntialController()
 }
}
//Functions
extension HomeViewController {
    

func changeIntialController(){
    
    let storyboard : UIStoryboard = StoryboardConstant.main
    let loginNavController = storyboard.instantiateViewController(identifier: "WelcomeNavVC")
    
    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
}
    
    
    func getAWSImage(faceURL:String) {
        //..........
        let url = URL(string: faceURL)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
         print("destData -  \(data)")
         print("compareData -  \(data)")
        
        destData = data
        compareData = data
        
    }
    
    
    
}
//Collection Vew
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = workoutCollectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutCVC", for: indexPath) as! WorkoutCVC
            let exerciseImage = workoutImg[indexPath.item]
            
            cell.workoutNameLbl.text = workoutName[indexPath.item]
            cell.workoutImg.image = UIImage(named: exerciseImage)
            cell.workoutBtn.tag = indexPath.item
            cell.workoutBtn.addTarget(self, action: #selector(goBtn), for: .touchUpInside)
            
            return cell
        }
    @objc func goBtn(_ sender: UIButton){
        let index = sender.tag
        print("index: \(index)")
        if index == 0 {
            let vc = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController            
                vc.selectedExercise = 5
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(identifier: "ExerciseOfTheDayVC") as! ExerciseOfTheDayVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//CollectionViewCell
class WorkoutCVC : UICollectionViewCell {
 
    @IBOutlet weak var workoutNameLbl : UILabel!
    @IBOutlet weak var workoutImg : UIImageView!
    @IBOutlet weak var workoutBtn : UIButton!
    
}
