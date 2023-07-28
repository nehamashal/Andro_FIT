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
    @IBOutlet weak var slideCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var emailLbl:UILabel!
    
    
    private var lastContentOffset: CGFloat = 0
    
    

    //AVCapture Configure
   
    
    var img = ["AIMotion1","AIMotion2","AIMotion3"]
    var text = ["Revolutionizing Your Workouts  \nwith Precision Motion Analysis.","Transform yourself with dedication, determination, and discipline.","Every step counts. Keep moving, keep thriving."]
    var currentIndex = 0
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = UserDefaults.standard.string(forKey: "userName") ?? "Neha"
        let categoryIcon = UserDefaults.standard.data(forKey: "profileimg") ?? Data()
        
        self.userImg.image = UIImage(data: categoryIcon )
        self.nameLbl.text = "Welcome \(userName)"
        
        
        self.workoutCollectionView.delegate = self
        self.slideCollectionView.delegate = self
        
        self.workoutCollectionView.dataSource = self
        self.slideCollectionView.dataSource = self
        
        pageController.currentPage = 0
        pageController.numberOfPages = img.count
    }
    override func viewDidLayoutSubviews() {
        scrollView.frame = (CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-200))
    }
    

}
//Buttons
extension HomeViewController {
    @IBAction func navButton(_ sender:UIButton){
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
    
   
    
}
//Collection Vew
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.workoutCollectionView {
                return workoutImg.count
            }
            return img.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == self.workoutCollectionView {
                let cell = workoutCollectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutCVC", for: indexPath) as! WorkoutCVC
                let exerciseImage = workoutImg[indexPath.item]
                
                cell.workoutNameLbl.text = workoutName[indexPath.item]
                cell.workoutImg.image = UIImage(named: exerciseImage)
                cell.workoutBtn.tag = indexPath.item
                cell.workoutBtn.addTarget(self, action: #selector(goBtn), for: .touchUpInside)
                
                return cell
            }else{
                let cell = slideCollectionView.dequeueReusableCell(withReuseIdentifier: "SlideCVC", for: indexPath) as! SlideCVC
                let images = img[indexPath.row]
                cell.slideImages.image = UIImage(named: images)
                cell.motionAnalysisLbl.text = text[indexPath.row]
                return cell
            }
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
    }}


extension HomeViewController {
    func moveCollectionToFrame(contentOffset : CGFloat) {
        pageController.currentPage = Int(contentOffset) / Int(self.slideCollectionView.frame.width)
        let frame: CGRect = CGRect(x : contentOffset ,y : self.slideCollectionView.contentOffset.y ,width : self.slideCollectionView.frame.width,height : self.slideCollectionView.frame.height)
            self.slideCollectionView.scrollRectToVisible(frame, animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print("scrollViewDidEndDecelerating")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.x) {
            // move up
            print("Change Prvious Button ")
        }
        else if (self.lastContentOffset < scrollView.contentOffset.x) {
           // move down
            print("changeNext Button ")
        }
        self.lastContentOffset = scrollView.contentOffset.x
        print("lastContentOffset",lastContentOffset)
    }
    @objc func pageControllerDidChange(_ sender: UIPageControl){
        let currentPage = sender.currentPage
        print("pagecontroller \(currentPage)")
        scrollView.setContentOffset(CGPoint(x: CGFloat(currentPage)*view.frame.size.width, y: 0), animated: true)
        if scrollView.subviews.count == 2{
            scrollView.isPagingEnabled = true
        }
    }
}

//CollectionViewCell
class WorkoutCVC : UICollectionViewCell {
 
    @IBOutlet weak var workoutNameLbl : UILabel!
    @IBOutlet weak var workoutImg : UIImageView!
    @IBOutlet weak var workoutBtn : UIButton!
    
}
class SlideCVC : UICollectionViewCell {
    @IBOutlet weak var slideImages: UIImageView!
    @IBOutlet weak var motionAnalysisLbl: UILabel!
    
}
