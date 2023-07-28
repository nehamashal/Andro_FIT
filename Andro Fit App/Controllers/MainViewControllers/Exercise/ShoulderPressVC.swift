//
//  ShoulderPressVC.swift
//  Andro Fit App
//
//  Created by Neha on 24/07/23.
//

import UIKit
import Vision
import AVFAudio

class ShoulderPressVC: UIViewController {
    
    @IBOutlet weak var exerciseNameLbl: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var setOfExercise: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}
extension ShoulderPressVC {
    /// - `Exercise`:  Shoulder Press
    func shoulderPress_Exercise(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
        guard let shoulderR = bodyParts[.rightShoulder]?.location,
              let shoulderL = bodyParts[.leftShoulder]?.location,
              let elbowR = bodyParts[.rightElbow]?.location,
              let elbowL = bodyParts[.leftElbow]?.location,
              let ankleL = bodyParts[.leftAnkle]?.location,
              let ankleR = bodyParts[.rightAnkle]?.location,
              let hipL = bodyParts[.leftHip]?.location,
              let hipR = bodyParts[.rightHip]?.location,
              let kneeL = bodyParts[.leftKnee]?.location,
              let kneeR = bodyParts[.rightKnee]?.location,
              let wristR = bodyParts[.rightWrist]?.location,
              let wristL = bodyParts[.leftWrist]?.location else {
            return
        }
        
        DispatchQueue.main.async {
            self.exerciseNameLbl.text = "Shoulder Press"
        }
        
        let hip_AngleR = calculateAngle(bodyPart1: shoulderR, bodyPart2: hipR, bodyPart3: kneeR) ?? 0
        let hip_AngleL = calculateAngle(bodyPart1: shoulderL, bodyPart2: hipL, bodyPart3: kneeL) ?? 0
        
        let shoulder_AngleR = calculateAngle(bodyPart1: hipR, bodyPart2: shoulderR, bodyPart3: elbowR) ?? 0
        let shoulder_AngleL = calculateAngle(bodyPart1: hipL, bodyPart2: shoulderL, bodyPart3: elbowL) ?? 0
        
        let elbow_AngleR = calculateAngle(bodyPart1: shoulderR, bodyPart2: elbowR, bodyPart3: wristR) ?? 0
        let elbow_AngleL = calculateAngle(bodyPart1: shoulderL, bodyPart2: elbowL, bodyPart3: wristL) ?? 0
        
        let angle_HEW_R = calculateAngle(bodyPart1: hipR, bodyPart2: elbowR, bodyPart3: wristR) ?? 0
        let angle_HEW_L = calculateAngle(bodyPart1: hipL, bodyPart2: elbowL, bodyPart3: wristL) ?? 0
        
        let knee_AngleR = calculateAngle(bodyPart1: hipR, bodyPart2: kneeR, bodyPart3: ankleR) ?? 0
        let knee_AngleL = calculateAngle(bodyPart1: hipL, bodyPart2: kneeL, bodyPart3: ankleL) ?? 0
        
        print("Angles:- hip: \(hip_AngleR) \(hip_AngleL) shoulder: \(shoulder_AngleR) \(shoulder_AngleL) elbow: \(elbow_AngleR) \(elbow_AngleL) HEW: \(angle_HEW_R) \(angle_HEW_L) knee: \(knee_AngleR) \(knee_AngleL) ")
        
        
        //   up:      60-160      150-180     130-180    100-180      60-160
        //   middle:  60-160       80-150      90-130     100-180     60-160
        //   down:    60-160       50-80       30-90      100-180     60-160
        
        
        
        if (hip_AngleR >= 60 && hip_AngleR <= 160) || (hip_AngleL >= 60 && hip_AngleL <= 160) {
            if shoulder_AngleR >= 150 || shoulder_AngleL >= 150 {
                if (elbow_AngleR >= 130 || elbow_AngleL <= 130) {
                    if (angle_HEW_R >= 100 || angle_HEW_L >= 100) {
                        if (knee_AngleR >= 60 && knee_AngleR <= 160) || (knee_AngleL >= 60 && knee_AngleL <= 160) {
 //  user's arms in an upper position
                            if shoulderPressCount == 0 {
                                DispatchQueue.main.async {
                                  //  self.textLbl.text = "Please be in a shoulder press exercise !"
                                }
                            }else{
                                //
                            }
                            properCount_SP = "0"
                            return
                        }else{
                            //knee
                            DispatchQueue.main.async {
                               // self.textLbl.text = "Wrong Knee Angle!"
                            }
                        }
                    }else{
                        //HEW
                        DispatchQueue.main.async {
                            //self.textLbl.text = "Wrong HEW Angle!"
                        }
                    }
                }else{
                    //elbow
                    DispatchQueue.main.async {
                       // self.textLbl.text = "Wrong elbow Angle!"
                    }
                }
        }else if (shoulder_AngleR >= 90 && shoulder_AngleR <= 150) || (shoulder_AngleL >= 90 && shoulder_AngleL <= 150) {
            if (elbow_AngleR >= 90 && elbow_AngleR < 130) || (elbow_AngleL >= 90 && elbow_AngleL < 130) {
                if (angle_HEW_R >= 100 || angle_HEW_L >= 100) {
                    if (knee_AngleR >= 60 && knee_AngleR <= 160) || (knee_AngleL >= 60 && knee_AngleL <= 160) {
 //  user's arms in a middle of shoulder-press position
                        if properCount_SP == "0" {
                            properCount_SP = "1"
                        }else{
                            
                        }
                        
                        return
                    }else{
                        //knee
                    }
                }else{
                    //HEW
                }
            }else{
                //elbow
            }
        }else if (shoulder_AngleR >= 40 && shoulder_AngleR < 90) || (shoulder_AngleL >= 40 && shoulder_AngleL < 90) {
            if (elbow_AngleR >= 30 && elbow_AngleR < 90) || (elbow_AngleL >= 30 && elbow_AngleL < 90) {
                if (angle_HEW_R >= 100 || angle_HEW_L >= 100) {
                    if (knee_AngleR >= 60 && knee_AngleR <= 160) || (knee_AngleL >= 60 && knee_AngleL <= 160) {
//  user's arms in down position
                        DispatchQueue.main.async {
                            self.actionLabel.text = "\(shoulderPressCount)"
                            set = shoulderPressCount / 15
                            self.setOfExercise.text = "\(set)/\(shoulderPressCount)"
                             if isSpeechCall_SP == false {
                                self.convertTextToSpeech(text: "You are currently performing the shoulder press exercise")
                                isSpeechCall_PU = false
                                isSpeechCall_S = false
                                isSpeechCall_SP = true
                            }
                        }
                        if properCount_SP == "1" {
                            shoulderPressCount += 1
                                DispatchQueue.main.async {
                                    self.actionLabel.text = "\(shoulderPressCount)"
                                }
                                countStore()
                                UserDefaults.standard.set(shoulderPressCount, forKey: "shoulderPressCount")
                            properCount_SP = "2"
                        }else{
                            if shoulderPressCount == 0 {
                                DispatchQueue.main.async {
                                   // self.textLbl.text = "Gesture ready!"
                                }
                            }else{
                                DispatchQueue.main.async {
                                   // self.textLbl.text = "Get ready for the next repetition of shoulder press."
                                }
                            }
                        }
                        return
                    }else{
                        //knee
                        DispatchQueue.main.async {
                           // self.textLbl.text = "Wrong Knee Angle!"
                        }
                    }
                }else{
                    //HEW
                    DispatchQueue.main.async {
                     //   self.textLbl.text = "Wrong HEW Angle!"
                    }
                }
            }else{
                //elbow
                DispatchQueue.main.async {
                   // self.textLbl.text = "Wrong elbow Angle!"
                }
            }
        }else{
            //shoulder
            DispatchQueue.main.async {
               // self.textLbl.text = "Wrong elbow Angle!"
            }
        }
    }else{
        //Hip
        DispatchQueue.main.async {
           // self.textLbl.text = "Wrong Hip Angle!"
        }
    }
    
    }
}
extension ShoulderPressVC {
    func calculateAngle(bodyPart1: CGPoint, bodyPart2: CGPoint, bodyPart3: CGPoint) -> Int? {
// Calculate the vectors between the points
        let vector1 = CGVector(dx: bodyPart1.x - bodyPart2.x, dy: bodyPart1.y - bodyPart2.y)
        let vector2 = CGVector(dx: bodyPart3.x - bodyPart2.x, dy: bodyPart3.y - bodyPart2.y)
// Calculate the angle between the vectors using dot product
        let dotProduct = vector1.dx * vector2.dx + vector1.dy * vector2.dy
        let magnitude1 = hypot(vector1.dx, vector1.dy)
        let magnitude2 = hypot(vector2.dx, vector2.dy)
// Calculate the angle in radians
        let angle = acos(dotProduct / (magnitude1 * magnitude2))
// Convert angle to degrees
        let angleDegrees = angle * 180.0 / .pi
            let a = angleDegrees
                if a.isFinite {
                    let b = Int(a)
                    return b
                }
        return 0
    }
    func countStore(){
        let squat = UserDefaults.standard.string(forKey: "squat_Count")
        let shoulderPress = UserDefaults.standard.string(forKey: "shoulderPressCount")
        let pushUps = UserDefaults.standard.string(forKey: "pushUp_Count")
        
        let localdata = [squat,shoulderPress,pushUps]
        print("localData \(localdata)")
        emptyArr = [squat_Count,pushUp_Count, shoulderPressCount,jump_Count]
        let totalCount = emptyArr.reduce(0, { $0 + $1 })
        exerciseArr = [totalCount, squat_Count, pushUp_Count, shoulderPressCount, jump_Count]
        UserDefaults.standard.set(exerciseArr, forKey: "Array")
    }
    func convertTextToSpeech(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Set the language for speech synthesis
        
        speechSynthesizer.speak(speechUtterance)
    }
}
