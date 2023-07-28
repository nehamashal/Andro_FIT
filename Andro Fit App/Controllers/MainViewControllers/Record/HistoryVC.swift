//
//  HistoryVC.swift
//  Andro Fit App
//
//  Created by Neha on 21/07/23.
//

import UIKit



 var listExcercise: [String] = ["All","squats","push_up","bench_press", "ic_jumping"]
 var nameExcercise: [String] = ["All","Squats","Push-Up","Shoulder Press", "Jumping"]

class HistoryVC: UIViewController {
    
    @IBOutlet weak var historyTV : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var filterView : UIView!
    @IBOutlet weak var filterViewWidthConstraint: NSLayoutConstraint!
    var screenName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.historyTV.delegate = self
        self.historyTV.dataSource = self
        updateSearchBar()
        
        if screenName == "Today" {
            self.titleLbl.text = "Today's Workout"
            self.filterView.isHidden = true
            self.filterViewWidthConstraint.constant = 0
            
        } else if screenName == "History" {
            self.titleLbl.text = "History"
            self.filterView.isHidden = false
            self.filterViewWidthConstraint.constant =  26
        }
        
        /*
         exerciseArr = [Int](repeating: 0, count: exerciseArr.count)
         UserDefaults.standard.removeObject(forKey: "Array")
         UserDefaults.standard.removeObject(forKey: "squat_Count")
         UserDefaults.standard.removeObject(forKey: "shoulderPressCount")
         UserDefaults.standard.removeObject(forKey: "pushUp_Count")
         recordTV.reloadData()*/
    }
    
}

// Buttons
extension HistoryVC {
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterBtn(_ sender: UIButton) {
        print("Filter")
    }
}

// Functions
extension HistoryVC {
    func updateSearchBar(){
        self.searchBar.setImage(UIImage(named: "Search"), for: .search, state: .normal)
        self.searchBar.searchTextField.backgroundColor = UIColor(hexString: "#333333")
        self.searchBar.searchTextField.textColor = .white
        self.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 13)
        self.searchBar.searchTextField.layer.cornerRadius = 20
        self.searchBar.searchTextField.layer.masksToBounds = true
        self.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Search by Name", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
    }
}

//Table View
extension HistoryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTV.dequeueReusableCell(withIdentifier: "HistoryTVC") as! HistoryTVC
        return cell
    }
}

//MARK: UITableViewCell
class HistoryTVC : UITableViewCell {
    @IBOutlet weak var exerciseName : UILabel!
    @IBOutlet weak var exerciseTiming : UILabel!
    @IBOutlet weak var exerciseDate : UILabel!
    @IBOutlet weak var exerciseImage : UIImageView!
    @IBOutlet weak var exerciseSet : UILabel!
    @IBOutlet weak var exerciseBtn : UIButton!
}
