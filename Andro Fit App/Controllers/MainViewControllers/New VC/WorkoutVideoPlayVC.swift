//
//  WorkoutVideoPlayVCViewController.swift
//  Andro Fit App
//
//  Created by Neha on 19/07/23.
//

import UIKit
import AVKit
import AVFoundation

class WorkoutVideoPlayVC: UIViewController, AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var videoView: UIImageView!
    @IBOutlet weak var exName : UILabel!
    var selectedWorkout: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedWorkout == 0 {
            self.exName.text = "Push Up"
            self.videoView.image = UIImage(named: "Pop-Push")
        }else if selectedWorkout == 1 {
            self.exName.text = "Squat"
            self.videoView.image = UIImage(named: "Pop-Squat")
        }else{
            self.exName.text = "Shoulder"
            self.videoView.image = UIImage(named: "Pop-Shoulder")
        }
    }
    
}

extension WorkoutVideoPlayVC {
    
    @IBAction func backBtn(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func playVider(_ sender: UIImage){
        if selectedWorkout == 0 {
            playVideo(VideoAddress: "PushUps")
        }else if selectedWorkout == 1 {
            playVideo(VideoAddress: "Squat")
        }else{
            playVideo(VideoAddress: "ShoulderPress")
        }
    }
}
extension WorkoutVideoPlayVC {
    
    private func playVideo(VideoAddress: String) {
           guard let path = Bundle.main.path(forResource: VideoAddress, ofType:"mp4") else {
               debugPrint("video.m4v not found")
               return
           }
           let player = AVPlayer(url: URL(fileURLWithPath: path))
           let playerController = AVPlayerViewController()
               playerController.player = player
               present(playerController, animated: true) {
                   player.play()
               }
       }

}
