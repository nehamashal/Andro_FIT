//
//  ExerciseOfTheDayVC.swift
//  Andro Fit App
//
//  Created by Neha on 18/07/23.
//

import UIKit

var dayImgExercise: [String] = ["PushUp", "Squat","Shoulder"]
var dayNameExercise: [String] = ["Push Up", "Squats","Shoulder"]

class ExerciseOfTheDayVC: UIViewController{
    
    @IBOutlet weak var dayOfExercise: UICollectionView!
    @IBOutlet weak var allTypeView: UIView!
    @IBOutlet weak var hideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayOfExercise.dataSource = self
        self.dayOfExercise.delegate = self
        self.allTypeView.layer.cornerRadius = 17
        self.allTypeView.layer.borderWidth = 3
        self.allTypeView.layer.borderColor = UIColor(hexString: "313131").cgColor
    }
}

//Buttons
extension ExerciseOfTheDayVC {
    @IBAction func backBtn(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

//Collection View
extension ExerciseOfTheDayVC : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dayOfExercise.dequeueReusableCell(withReuseIdentifier: "WorkoutCVC", for: indexPath) as! WorkoutCVC
        let image = dayImgExercise[indexPath.item]
        
        cell.workoutImg.image = UIImage(named: image)
        cell.workoutNameLbl.text = dayNameExercise[indexPath.item]
        
        cell.workoutBtn.tag = indexPath.item
        cell.workoutBtn.addTarget(self, action: #selector(goBtn), for: .touchUpInside)
        
        return cell
    }
@objc func goBtn(_ sender: UIButton){
    let index = sender.tag
    print("index: \(index)")
    let vc = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        vc.selectedExercise = index
        vc.excerciseName = nameExcercise[index]
    self.navigationController?.pushViewController(vc, animated: true)
    
}
}

