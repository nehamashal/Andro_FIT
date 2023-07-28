//
//  SquatVC.swift
//  Andro Fit App
//
//  Created by Neha on 24/07/23.
//

import UIKit
import Vision
import AVFAudio
import AVFoundation


class SquatVC: UIViewController {

    @IBOutlet weak var exerciseNameLbl: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var setOfExercise: UILabel!
    
    
    var bodyParts = [VNHumanBodyPoseObservation.JointName : VNRecognizedPoint]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension SquatVC {
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


/// - `Exercise` :  Squat
extension SquatVC {
    
    func squat_Exercise(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
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
            self.exerciseNameLbl.text = "Squats"
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
        
        // up :       160-180   80-150   0-50    0-90   160-180
        // middle:    130-160   80-150   0-50    0-90   140-160
        // down :     80-130    80-150   0-50    0-90   110-140
        
        if (hip_AngleR > 160 || hip_AngleL > 160) {
            if (shoulder_AngleR >= 80 && shoulder_AngleR <= 150) || (shoulder_AngleL >= 110 && shoulder_AngleL <= 130) {
                if (elbow_AngleR < 50 || elbow_AngleL < 50) {
                    if (angle_HEW_R <= 90 || angle_HEW_L <= 90) {
                        if (knee_AngleR > 160 || knee_AngleL > 160) {
 //  user in an upper position
                            DispatchQueue.main.async {
                                self.actionLabel.text = "\(squat_Count)"
                                 if isSpeechCall_S == false {
                                    self.convertTextToSpeech(text: "You are currently performing the squat exercise")
                                    isSpeechCall_PU = false
                                    isSpeechCall_S = true
                                    isSpeechCall_SP = false
                                }
                            }
                            if squat_Count == 0 {
                                DispatchQueue.main.async {
                                   //self.textLbl.text = "Get ready for the repetition of squats"
                                }
                            }else{
                                DispatchQueue.main.async {
                                    //self.textLbl.text = "Get ready for the next repetition of squats."
                                }
                            }
                            properCount_Sq = "0"
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
            }else{
                //shoulder
            }
        }else if (hip_AngleR >= 140 && hip_AngleR <= 160) || (hip_AngleL >= 140 && hip_AngleL <= 160) {
            if (shoulder_AngleR >= 80 && shoulder_AngleR <= 150) || (shoulder_AngleL >= 80 && shoulder_AngleL <= 150) {
                if (elbow_AngleR < 50 || elbow_AngleL < 50) {
                    if (angle_HEW_R <= 90 || angle_HEW_L <= 90) {
                        if (knee_AngleR >= 140 && knee_AngleR <= 160) || (knee_AngleL >= 140 && knee_AngleL <= 160) {
 //  user in a middle of squat position
                            if properCount_Sq == "0" {
                                properCount_Sq = "1"
                            }else{
                                //
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
            }else{
                //shoulder
            }
        }else if (hip_AngleR >= 80 && hip_AngleR < 140) || (hip_AngleL >= 80 && hip_AngleL < 140) {
            if (shoulder_AngleR >= 80 && shoulder_AngleR <=  150) || (shoulder_AngleL >= 80 && shoulder_AngleL <=  150) {
                if (elbow_AngleR < 50 || elbow_AngleL < 50) {
                    if (angle_HEW_R < 90 || angle_HEW_L < 90) {
                        if (knee_AngleR >= 100 && knee_AngleR < 160) || (knee_AngleL >= 100 && knee_AngleL < 160) {
//  user in a down position
                            
                            
                            if properCount_Sq == "1" {
                                squat_Count += 1
                                    DispatchQueue.main.async {
                                        self.actionLabel.text = "\(squat_Count)"
                                        set = squat_Count / 15
                                        self.setOfExercise.text = "\(set)/\(squat_Count)"
                                    }
                                    countStore()
                                UserDefaults.standard.set(squat_Count, forKey: "squat_Count")
                                properCount_Sq = "2"
                            }else{
                                if squat_Count == 0 {
                                    DispatchQueue.main.async {
                                      //  self.textLbl.text = "Please Stand up staight for squat exercise!"
                                    }
                                }else{
                                    DispatchQueue.main.async {
                                       // self.textLbl.text = "Get ready for the next repetition of squats."
                                    }
                                }
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
            }else{
                //shoulder
            }
        }else{
            //hip
        }
    }
    
}
