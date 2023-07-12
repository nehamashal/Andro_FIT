//
//  RecordOfExerciseVC.swift
//  Andro Fit
//
//  Created by Neha on 06/07/23.
//

import UIKit

class RecordOfExerciseVC: UIViewController {
    
    @IBOutlet weak var recordTV: UITableView!
    @IBOutlet weak var restartBtnView: UIView!

    var model = ExerciseModel(listExercise: listExcercise, nameExercise: nameExcercise, exerciseArr: exerciseArr,count: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Retrieve the stored array from UserDefaults, if available
        if let storedArray = UserDefaults.standard.array(forKey: "ExerciseArray") as? [Int] {
            exerciseArr = storedArray
            print("changeValue \(storedArray)")
        } else {
            let exerciseArr = Array(repeating: 0, count: 5)
            let changeValue = exerciseArr // Default values for exerciseArr
            print("changeValue \(changeValue)")
        }
        print("array: \(exerciseArr)")
        recordTV.delegate = self
        recordTV.dataSource = self
        
        restartBtnView.layer.borderWidth = 1
        restartBtnView.layer.borderColor = UIColor.white.cgColor
        restartBtnView.simpleWhiteShadow()
    }
}

// Buttons
extension RecordOfExerciseVC {
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        exerciseArr = [Int](repeating: 0, count: exerciseArr.count)
        UserDefaults.standard.removeObject(forKey: "ExerciseArray")
        recordTV.reloadData()
    }
}

// TableView
extension RecordOfExerciseVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordTV.dequeueReusableCell(withIdentifier: "RecordOfExerciseTVC", for: indexPath) as! RecordOfExerciseTVC
        let imgEX = model.listExercise[indexPath.row]
        let nameEX = model.nameExercise[indexPath.row]
//        let countEX = model.exerciseArr[indexPath.row]
       
        // Check if exerciseArr has enough elements for the current indexPath.row
           if indexPath.row < model.exerciseArr.count {
               let countEX = model.exerciseArr[indexPath.row]
               cell.exCount.text = "\(countEX)"
               
               // Store the value in UserDefaults
               let key = "ExerciseCount_\(indexPath.row)"
               UserDefaults.standard.set(countEX, forKey: key)
           } else {
               // Default value when exerciseArr is empty or doesn't have enough elements
               let countEX = 0
               cell.exCount.text = "\(countEX)"
           }
        
        cell.exImg.image = UIImage(named: imgEX)
        cell.exName.text = nameEX
        
        
        return cell
    }
}

// MARK: TableViewCell
class RecordOfExerciseTVC: UITableViewCell {
    @IBOutlet weak var exImg: UIImageView!
    @IBOutlet weak var exName: UILabel!
    @IBOutlet weak var exCount: UILabel!
    @IBOutlet weak var mainView:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

struct ExerciseModel {
    var listExercise: [String]
    var nameExercise: [String]
    var exerciseArr: [Int]
    var count = 5
}
