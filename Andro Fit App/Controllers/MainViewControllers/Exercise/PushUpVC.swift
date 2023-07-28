//
//  PushUpVC.swift
//  Andro Fit App
//
//  Created by Neha on 24/07/23.
//

import UIKit
import Vision
import AVFAudio

class PushUpVC: UIViewController {

    @IBOutlet weak var exerciseNameLbl: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var setOfExercise: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

}


/// - `Exercise` :  Push-ups
extension PushUpVC {
    func pushUp_Exercise(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
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
            self.exerciseNameLbl.text = "Push Ups"
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
        
       
        
        
        //   up:      160-180     50-80       140-180     100-130      160-180
        //   middle:  160-180     30-50      100-140     100-130    160-180
        //   down:    160-180      0-30       0-100    100-180     160-180
        
        
        if (hip_AngleR > 160 || hip_AngleL > 160) {
            if (shoulder_AngleR > 50 && shoulder_AngleR <= 80) || (shoulder_AngleL > 50 && shoulder_AngleL <= 80) {
                if (elbow_AngleR > 140 || elbow_AngleL > 140) {
                    if (angle_HEW_R >= 100 && angle_HEW_R <= 130) || (angle_HEW_L >= 100 && angle_HEW_L <= 130) {
                        if (knee_AngleR > 160 || knee_AngleL > 160) {
//  user's arms in an upper position
                            DispatchQueue.main.async {
                                self.actionLabel.text = "\(pushUp_Count)"
                                 if isSpeechCall_PU == false {
                                    self.convertTextToSpeech(text: "You are currently performing the push-up exercise")
                                    isSpeechCall_PU = true
                                    isSpeechCall_S = false
                                    isSpeechCall_SP = false
                                }
                            }
                            if pushUp_Count == 0 {
                                DispatchQueue.main.async {
                                   // self.textLbl.text = "Get ready for the repetition of Push-Ups"
                                }
                            }else{
                                DispatchQueue.main.async {
                                   // self.textLbl.text = "Get ready for the next repetition of Push-Ups."
                                }
                            }
                            properCount_PU = "0"
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
            }else if (shoulder_AngleR >= 30 && shoulder_AngleR <= 50) || (shoulder_AngleL >= 30 && shoulder_AngleL <= 50) {
                if (elbow_AngleR >= 100 && elbow_AngleR <= 140) || (elbow_AngleL >= 100 && elbow_AngleL <= 140) {
                    if (angle_HEW_R >= 100 && angle_HEW_R <= 130) || (angle_HEW_L >= 100 && angle_HEW_L <= 130) {
                        if (knee_AngleR >= 160 || knee_AngleL >= 160) {
 //  user's arms in a middle of push-ups position
                            if properCount_PU == "0" {
                                properCount_PU = "1"
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
            }else if (shoulder_AngleR < 30 || shoulder_AngleL < 30) {
                if (elbow_AngleR < 100 || elbow_AngleL < 100) {
                    if (angle_HEW_R > 100 || angle_HEW_L > 100) {
                        if (knee_AngleR >= 160 || knee_AngleL >= 160) {
 //  user's arms in a down position
                            if properCount_PU == "1" {
                                pushUp_Count += 1
                                    DispatchQueue.main.async {
                                        self.actionLabel.text = "\(pushUp_Count)"
                                        set = pushUp_Count / 15
                                        self.setOfExercise.text = "\(set)/\(pushUp_Count)"
                                    }
                                    countStore()
                                    UserDefaults.standard.set(pushUp_Count, forKey: "pushUp_Count")
                                properCount_PU = "2"
                            }else{
                                if pushUp_Count == 0 {
                                    DispatchQueue.main.async {
                                      //  self.textLbl.text = "Please be in proper push-ups exercise position !"
                                    }
                                }else{
                                    DispatchQueue.main.async {
                                      //  self.textLbl.text = "Get ready for the next repetition of Push-Ups."
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
extension PushUpVC {
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
