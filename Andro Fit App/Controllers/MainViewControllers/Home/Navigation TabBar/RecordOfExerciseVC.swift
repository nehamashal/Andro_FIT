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
    @IBOutlet weak var backBtnView: UIView!

    var hideBackBtn = true
    
    var model = ExerciseModel(listExercise: listExcercise, nameExercise: nameExcercise, exerciseArr: exerciseArr,count: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        print("array: \(exerciseArr)")
        
        recordTV.delegate = self
        recordTV.dataSource = self
        
        restartBtnView.layer.borderWidth = 1
        restartBtnView.layer.borderColor = UIColor.white.cgColor
        restartBtnView.simpleWhiteShadow()
        if hideBackBtn {
            self.backBtnView.isHidden = false
        }else{
            self.backBtnView.isHidden = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordTV.reloadData() // Reload the table view to display the updated counts
    }
}

// Buttons
extension RecordOfExerciseVC {
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        exerciseArr = [Int](repeating: 0, count: exerciseArr.count)
        UserDefaults.standard.removeObject(forKey: "Array")
        UserDefaults.standard.removeObject(forKey: "squat_Count")
        UserDefaults.standard.removeObject(forKey: "shoulderPressCount")
        UserDefaults.standard.removeObject(forKey: "pushUp_Count")
        recordTV.reloadData()
    }
}

// TableView
extension RecordOfExerciseVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
  /*  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordTV.dequeueReusableCell(withIdentifier: "RecordOfExerciseTVC", for: indexPath) as! RecordOfExerciseTVC
        let imgEX = model.listExercise[indexPath.row]
        let nameEX = model.nameExercise[indexPath.row]
        
        var countEX = 0 // Declare a local variable to store the exercise count
        
        // Check if exerciseArr has enough elements for the current indexPath.row
        if indexPath.row < model.exerciseArr.count {
            countEX = model.exerciseArr[indexPath.row]
        }
        
        // Display the value in the cell
        cell.exCount.text = "\(countEX)"
        
        // Store the value in UserDefaults
        let key = "ExerciseCount_\(indexPath.row)"
        UserDefaults.standard.set(countEX, forKey: key)
        
        cell.exImg.image = UIImage(named: imgEX)
        cell.exName.text = nameEX
        
        return cell
    }*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordTV.dequeueReusableCell(withIdentifier: "RecordOfExerciseTVC", for: indexPath) as! RecordOfExerciseTVC
        let imgEX = model.listExercise[indexPath.row]
        let nameEX = model.nameExercise[indexPath.row]

        if let storedArray = UserDefaults.standard.array(forKey: "Array") as? [Int] {
            if indexPath.row < storedArray.count {
                cell.exCount.text = "\(storedArray[indexPath.row])"
            } else {
                cell.exCount.text = "0"
            }
        } else {
            cell.exCount.text = "0"
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
