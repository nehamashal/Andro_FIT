//
//  Work_Out_List.swift
//  Gym App
//
//  Created by Neha on 19/06/23.
//

import UIKit

class WorkOut_ListVC: UIViewController {
    
    @IBOutlet weak var listCollection: UICollectionView!

    var listExcercise = ["squats","push_up","bench_press", "ic_jumping"]
    
    var nameExcercise = ["Squats","Push-Up","Shoulder Press", "Jumping"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listCollection.delegate = self
        listCollection.dataSource = self
    }
}

extension WorkOut_ListVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        self.navigationController?.pushViewController(vc, animated: true)
      }
}


class WorkOut_ListTVC : UICollectionViewCell{
    @IBOutlet weak var imageList:UIImageView!
    @IBOutlet weak var goBtn:UIButton!
    @IBOutlet weak var nameExc:UILabel!
    override func awakeFromNib() {
        self.imageList.layer.cornerRadius = 20
        self.imageList.layer.borderWidth = 1
    }
}
