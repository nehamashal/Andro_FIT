//
//  MainViewController.swift
//  MLKIT Demo App
//
//  Created by Neha on 14/06/23.
//


import UIKit
import Vision
import CoreGraphics
import AVFoundation

@available(iOS 14.0, *)


var exerciseArr:[Int] = []
class MainViewController: UIViewController,UIGestureRecognizerDelegate {


    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var labelStack: UIStackView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var toastView: UIView!

//    @IBOutlet weak var animationView:UIView!
//    @IBOutlet weak var playBtnImg:UIImageView!
//    @IBOutlet weak var counterLabel:UILabel!
//    @IBOutlet weak var counterView:UIView!
//    @IBOutlet weak var playBtnView:UIView!
//    @IBOutlet weak var excerciseNameLbl:UILabel!
    
    

    var videoCapture: VideoCapture!
    var videoProcessingChain: VideoProcessingChain!
    var actionFrameCounts = [String: Int]()
    var bodyParts = [VNHumanBodyPoseObservation.JointName : VNRecognizedPoint]()
    
    var index_Ex = 0
    var playbtntapped = true
    var timer = Timer()
    var excerciseName = ""
    var selectedExercise = 0
    
    var properCount_Sq = ""
    var properCount_PU = ""
    var properCount_SP = ""
    
    
    var squat_Position = "up"
    var arm_Position = "up"
    var pushUp_Position = "down"
    
    var total_Count = 0
    var squat_Count = 0
    var pushUp_Count = 0
    var shoulderPressCount = 0
    var jump_Count = 0
    
    var emptyArr:[Int] = []
    
    var isSpeechCall_S = false
    var isSpeechCall_PU = false
    var isSpeechCall_SP = false
    
    let speechSynthesizer = AVSpeechSynthesizer()
}

// MARK: - View Controller Events
extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        index_Ex = selectedExercise
//        self.textLbl.text = "Please take your position and start Tracking your Excercise by tapping on play Button"
        
        UIApplication.shared.isIdleTimerDisabled = true
        UIApplication.shared.isIdleTimerDisabled = true

        videoProcessingChain = VideoProcessingChain()
        
        videoProcessingChain.delegate = self

        videoCapture = VideoCapture()
        videoCapture.delegate = self

        //updateUILabelsWithPrediction(.startingPrediction)
        
      /*  self.counterView.layer.borderColor = UIColor.white.cgColor
        self.counterView.layer.cornerRadius = self.counterView.bounds.height / 2
        self.counterView.layer.borderWidth = 5
        self.animationView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.animationView.isHidden = true
        self.counterView.isHidden = true
        self.playBtnImg.image = UIImage(systemName: "play.circle.fill")
        self.playBtnView.layer.cornerRadius = self.playBtnView.bounds.height / 2
        self.excerciseNameLbl.text =  self.excerciseName */
        
//        let synth = AVSpeechSynthesizer()
//        let myUtterance = AVSpeechUtterance(string: "Please Stand Up ")
//        myUtterance.rate = 0.4
//        synth.speak(myUtterance)
        
        self.imageView.backgroundColor = .black
        self.imageView.isUserInteractionEnabled = true
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.didTapView(_:)))
        gesture.delegate = self
        gesture.numberOfTapsRequired = 1
        self.imageView.addGestureRecognizer(gesture)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.playbtntapped = false
//        }
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
    @objc func didTapView(_ gesture: UITapGestureRecognizer) {
        print("did tap view", gesture)
      /*  self.animationView.isHidden = false
        self.playBtnImg.image = UIImage(systemName: "pause.circle.fill")
        self.playBtnView.isHidden = false
        DispatchQueue.main.async {
            if self.playbtntapped {
                self.animationView.isHidden = true
                self.playBtnView.isHidden = true
            }
        }*/
    }
    func startTimer() {
//           var counter = 5
           
         /*  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
               self.animationView.isHidden = false
               self.counterView.isHidden = false
               self.counterLabel.text = "\(counter)"
               
               if counter > 0 {
                   counter -= 1
               } else {
                   self.animationView.isHidden = true
                   self.counterView.isHidden = true
                   timer.invalidate()
               }
           }*/
       }
     
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoCapture.updateDeviceOrientation()
    }

    override func viewWillTransition(to size: CGSize,with coordinator: UIViewControllerTransitionCoordinator) {
        videoCapture.updateDeviceOrientation()
    }
}

// MARK: - Button Events
extension MainViewController {
    @IBAction func onCameraButtonTapped(_: Any) {
        videoCapture.toggleCameraSelection()
    }
    @IBAction func historyBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "RecordOfExerciseVC") as! RecordOfExerciseVC
        vc.hideBackBtn = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backButton(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionPlayVideo(_ sender:UIButton){
//        playbtntapped = !playbtntapped
//        print("play Button tapped \(playbtntapped)")
      /*  if playbtntapped {
            
            self.playBtnImg.image = UIImage(systemName: "pause.circle.fill")
            print("play Button  True - Video play (⏸️) : \(playbtntapped)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.animationView.isHidden = true
                self.playBtnView.isHidden = true
                self.startTimer()
            }
        }else {
            self.playBtnImg.image = UIImage(systemName: "play.circle.fill")
            print("play Button False - Video pause (▶️) : \(playbtntapped)")
        }*/
    }
}

// MARK: - Video Capture Delegate
extension MainViewController: VideoCaptureDelegate {
    func videoCapture(_ videoCapture: VideoCapture,didCreate framePublisher: FramePublisher) {
        print("videoCapturedidCreate")
//        if self.playbtntapped {
           // updateUILabelsWithPrediction(.startingPrediction)
            videoProcessingChain.upstreamFramePublisher = framePublisher
//        }
    }
}

// MARK: - video-processing chain Delegate
extension MainViewController: VideoProcessingChainDelegate {
    func videoProcessingChain(_ chain: VideoProcessingChain,
                              didPredict actionPrediction: ActionPrediction,
                              for frameCount: Int) {
        print("videoCapturedidPredict")
//        if self.playbtntapped {
            if actionPrediction.isModelLabel {
                addFrameCount(frameCount, to: actionPrediction.label)
//            }
            //updateUILabelsWithPrediction(actionPrediction)
        }
    }

    /// - Parameters:
    ///   - chain: A video-processing chain.
    ///   - poses: A `Pose` array.
    ///   - frame: A video frame as a `CGImage`.
    ///
    func videoProcessingChain(_ chain: VideoProcessingChain,didDetect poses: [PoseS]?,in frame: CGImage) {
        DispatchQueue.global(qos: .userInteractive).async {
//            if self.playbtntapped {
                self.drawPoses(poses, onto: frame)
            
                print("selectedExercise \(self.index_Ex)")
            
                if self.index_Ex == 0 {
                    self.all(bodyParts: self.bodyParts)
                }else if self.index_Ex == 1 {
                    self.squats(bodyParts: self.bodyParts)
                }else if self.index_Ex == 2 {
                    self.pushUps(bodyParts: self.bodyParts)
                }else if self.index_Ex == 3 {
                    self.shoulderPress(bodyParts: self.bodyParts)
                }else{
                    self.ResetTheAllFucntion(bodyParts:self.bodyParts)
                }
            
//            }
        }
    }
}

// MARK: - Helper methods
extension MainViewController {
    /// - Parameters:
    ///   - actionLabel: The name of the action.
    private func addFrameCount(_ frameCount: Int, to actionLabel: String) {
        // Add the new duration to the current total, if it exists.
        let totalFrames = (actionFrameCounts[actionLabel] ?? 0) + frameCount

        // Assign the new total frame count for this action.
        actionFrameCounts[actionLabel] = totalFrames
    }

    /// Updates the user interface's labels with the prediction and its
    /// confidence.
    /// - Parameters:
    ///   - label: The prediction label.
    ///   - confidence: The prediction's confidence value.
    private func updateUILabelsWithPrediction(_ prediction: ActionPrediction) {
        // Update the UI's prediction label on the main thread.
        DispatchQueue.main.async {
            //self.actionLabel.text = prediction.label
            
        }

        // Update the UI's confidence label on the main thread.
        let confidenceString = prediction.confidenceString ?? ""
        DispatchQueue.main.async {
            
            self.confidenceLabel.text = "Confidence: \(confidenceString)"
        }
    }

    /// Draws poses as wireframes on top of a frame, and updates the user
    /// interface with the final image.
    /// - Parameters:
    ///   - poses: An array of human body poses.
    ///   - frame: An image.
    /// - Tag: drawPoses
   private func drawPoses(_ poses: [PoseS]?, onto frame: CGImage) {
        
        // Create a default render format at a scale of 1:1.
        let renderFormat = UIGraphicsImageRendererFormat()
        renderFormat.scale = 1.0

        // Create a renderer with the same size as the frame.
        let frameSize = CGSize(width: frame.width, height: frame.height)
        let poseRenderer = UIGraphicsImageRenderer(size: frameSize,
                                                   format: renderFormat)

        // Draw the frame first and then draw pose wireframes on top of it.
        let frameWithPosesRendering = poseRenderer.image { rendererContext in
            // The`UIGraphicsImageRenderer` instance flips the Y-Axis presuming
            // we're drawing with UIKit's coordinate system and orientation.
            let cgContext = rendererContext.cgContext

            // Get the inverse of the current transform matrix (CTM).
            let inverse = cgContext.ctm.inverted()

            // Restore the Y-Axis by multiplying the CTM by its inverse to reset
            // the context's transform matrix to the identity.
            cgContext.concatenate(inverse)

            // Draw the camera image first as the background.
            let imageRectangle = CGRect(origin: .zero, size: frameSize)
            cgContext.draw(frame, in: imageRectangle)

            // Create a transform that converts the poses' normalized point
            // coordinates `[0.0, 1.0]` to properly fit the frame's size.
            let pointTransform = CGAffineTransform(scaleX: frameSize.width,
                                                   y: frameSize.height)

            guard let poses = poses else { return }

            // Draw all the poses Vision found in the frame.
            for pose in poses {
                // Draw each pose as a wireframe at the

                self.bodyParts = videoProcessingChain.detectedBodyPose()
                print("bodyPart in Main View Controller \(self.bodyParts)")
                pose.drawWireframeToContext(cgContext, applying: pointTransform)
                
            }
        }

        // Update the UI's full-screen image view on the main thread.
        DispatchQueue.main.async {
            self.imageView.image = frameWithPosesRendering
        }
    }

    func calculateDifference(shoulder: CGPoint, hip: CGPoint) -> CGFloat {
        let dx = hip.x - shoulder.x
        let dy = hip.y - shoulder.y
        let difference = sqrt(dx*dx + dy*dy)
        return difference
    }
    
    func processBodyPoseObservations(_ observations: [VNHumanBodyPoseObservation]) {
        // Process each body pose observation
        for observation in observations {
            guard let recognizedPoints = try? observation.recognizedPoints(forGroupKey: .all) else {
                continue
            }
        }
    }
   
    func convertTextToSpeech(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Set the language for speech synthesis
        
        speechSynthesizer.speak(speechUtterance)
    }

    
    func transformMatrix() -> CGAffineTransform {
      guard let image = imageView.image else { return CGAffineTransform() }
            let imageViewWidth = imageView.frame.size.width
            let imageViewHeight = imageView.frame.size.height
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            let imageViewAspectRatio = imageViewWidth / imageViewHeight
            let imageAspectRatio = imageWidth / imageHeight
            let scale = (imageViewAspectRatio > imageAspectRatio) ? imageViewHeight / imageHeight : imageViewWidth / imageWidth
            let scaledImageWidth = imageWidth * scale
            let scaledImageHeight = imageHeight * scale
            let xValue = (imageViewWidth - scaledImageWidth) / CGFloat(2.0)
            let yValue = (imageViewHeight - scaledImageHeight) / CGFloat(2.0)
            var transform = CGAffineTransform.identity.translatedBy(x: xValue, y: yValue)
                transform = transform.scaledBy(x: scale, y: scale)
      return transform
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
}

//MARK:  All Exercise & CalculateAngle
extension MainViewController{
    
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

}

//MARK:  Squat, PushUps , Shoulder Press
extension MainViewController{
    
    func squats(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
        guard let kneeR = bodyParts[.rightKnee]?.location,
              let kneeL = bodyParts[.leftKnee]?.location,
              let hipR = bodyParts[.rightHip]?.location,
              let hipL = bodyParts[.leftHip]?.location,
              let ankleR = bodyParts[.rightAnkle]?.location,
              let ankleL = bodyParts[.leftAnkle]?.location,
              let shoulderR = bodyParts[.rightShoulder]?.location,
              let shoulderL = bodyParts[.leftShoulder]?.location,
              let wristR = bodyParts[.rightWrist]?.location,
              let wristL = bodyParts[.leftWrist]?.location,
              let elbowR = bodyParts[.rightElbow]?.location,
              let elbowL = bodyParts[.leftElbow]?.location else {
            
            return
        }
        
        let hip_AngleR = calculateAngle(bodyPart1: shoulderR, bodyPart2: hipR, bodyPart3: kneeR) ?? 0
        let hip_AngleL = calculateAngle(bodyPart1: shoulderL, bodyPart2: hipL, bodyPart3: kneeL) ?? 0
        
        let knee_AngleL = calculateAngle(bodyPart1: hipL, bodyPart2: kneeL, bodyPart3: ankleL) ?? 0
        let knee_AngleR = calculateAngle(bodyPart1: hipR, bodyPart2: kneeR, bodyPart3: ankleR) ?? 0
        
        let elbow_AngleL = calculateAngle(bodyPart1: shoulderL, bodyPart2: elbowL, bodyPart3: wristL) ?? 0
        let elbow_AngleR = calculateAngle(bodyPart1: shoulderR, bodyPart2: elbowR, bodyPart3: wristR) ?? 0
        
        let shoulder_AngleL = calculateAngle(bodyPart1: hipL, bodyPart2: shoulderL, bodyPart3: elbowL) ?? 0
        let shoulder_AngleR = calculateAngle(bodyPart1: hipR, bodyPart2: shoulderR, bodyPart3: elbowR) ?? 0
        
        print("Angle hip: \(hip_AngleL) \(hip_AngleR)  knee: \(knee_AngleL) \(knee_AngleR) Elbow: \(elbow_AngleL) \(elbow_AngleR) Shoulder: \(shoulder_AngleL) \(shoulder_AngleR)")
        
        
        
        if ((hip_AngleL > 150 || hip_AngleR > 150)
            && (knee_AngleL > 150 || knee_AngleR > 150)) {
            self.squat_Position = "up"
            DispatchQueue.main.async {
                self.actionLabel.text = "Squats: \(self.squat_Count)"
                if self.isSpeechCall_S == false {
                    self.convertTextToSpeech(text: "You are currently performing the squat exercise")
                    self.isSpeechCall_S = true
                    self.isSpeechCall_PU = false
                    self.isSpeechCall_SP = false
                }
           }
        }else if (((hip_AngleL >= 100 && hip_AngleL <= 150)
                   || (hip_AngleR >= 100 && hip_AngleR <= 150))
                 && ((knee_AngleL >= 100 && knee_AngleL <= 150)
                   || (knee_AngleR >= 100 && knee_AngleR <= 150))) {
            self.squat_Position = "middle"
        }else if ((hip_AngleL < 100 || hip_AngleR < 100)
                  && (knee_AngleL < 100 || knee_AngleR < 100)) {
            self.squat_Position = "down"
        }else {
            DispatchQueue.main.async {
                self.textLbl.text = "Please ensure proper posture and aim for a deeper squat position for maximum effectiveness."
            }
        }
       
        if self.squat_Position == "up" {
            if ((elbow_AngleL >= 150 || elbow_AngleR >= 150) || (elbow_AngleL <= 40) || (elbow_AngleR <= 40)) {
                
                if squat_Count == 0 && properCount_Sq == ""{
                    DispatchQueue.main.async {
                      self.textLbl.text = "Get ready for the first repetition of squats."
                    }
                }else{
                    if properCount_Sq == "0" {
                         DispatchQueue.main.async {
                            self.textLbl.text = "Get ready for the next repetition of squats."
                         }
                         if ((shoulder_AngleL >= 80 && shoulder_AngleL <= 140) || (shoulder_AngleR >= 80 && shoulder_AngleR <= 140)){
                             properCount_Sq = "1"
                             squat_Count += 1
                             DispatchQueue.main.async {
                                self.actionLabel.text = "Squats: \(self.squat_Count)"
                             }
                             countStore()
                             UserDefaults.standard.set(squat_Count, forKey: "squat_Count")
                         }else{
                             DispatchQueue.main.async {
                                self.textLbl.text = "Maintain the correct shoulder angle while performing squats."
                             }
                         }
                    }else{
                       //up else
                    }
                }
        }else{
           DispatchQueue.main.async {
             self.textLbl.text = "Please correct the angle of your elbows for proper squat execution."
           }
        }
      }else if self.squat_Position == "middle" {
               if properCount_Sq == "" {
                  properCount_Sq = "0"
               }else {
                 DispatchQueue.main.async {
                   self.textLbl.text = "Execute the squat exercise with proper form and technique"
                 }
            }
        }else {
            properCount_Sq = ""
            DispatchQueue.main.async {
                self.textLbl.text = "Get ready for the next repetition. You're doing great! \(self.properCount_Sq)"
            }
        }
    }

    func pushUps(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
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
        
        
        let hip_AngleR = calculateAngle(bodyPart1: shoulderR, bodyPart2: hipR, bodyPart3: kneeR) ?? 0
        let hip_AngleL = calculateAngle(bodyPart1: shoulderL, bodyPart2: hipL, bodyPart3: kneeL) ?? 0
        
        let shoulder_AngleL = calculateAngle(bodyPart1: hipL, bodyPart2: shoulderL, bodyPart3: elbowL) ?? 0
        let shoulder_AngleR = calculateAngle(bodyPart1: hipR, bodyPart2: shoulderR, bodyPart3: elbowR) ?? 0
        
        let elbow_AngleR = calculateAngle(bodyPart1: shoulderR, bodyPart2: elbowR, bodyPart3: wristR) ?? 0
        let elbow_AngleL = calculateAngle(bodyPart1: shoulderL, bodyPart2: elbowL, bodyPart3: wristL) ?? 0
        
        let angle_HEW_R = calculateAngle(bodyPart1: hipR, bodyPart2: elbowR, bodyPart3: wristR) ?? 0
        let angle_HEW_L = calculateAngle(bodyPart1: hipL, bodyPart2: elbowL, bodyPart3: wristL) ?? 0
        
        let knee_AngleL = calculateAngle(bodyPart1: hipL, bodyPart2: kneeL, bodyPart3: ankleL) ?? 0
        let knee_AngleR = calculateAngle(bodyPart1: hipR, bodyPart2: kneeR, bodyPart3: ankleR) ?? 0
        
        print("elbow angle: \(elbow_AngleR) \(elbow_AngleL) shoulder: \(shoulder_AngleL) \(shoulder_AngleR) knee: \(knee_AngleL) \(knee_AngleR) ankle: \(angle_HEW_R) \(angle_HEW_L) hip: \(hip_AngleR) \(hip_AngleL)")
      
        
        if ((angle_HEW_L > 100 || angle_HEW_R > 100)
            && (knee_AngleL > 150 || knee_AngleR > 150)) {
            
            if (elbow_AngleR > 130) {
                self.pushUp_Position = "Up"
                DispatchQueue.main.async {
                    self.actionLabel.text = "Push-Ups \(self.pushUp_Count)"
                    if self.isSpeechCall_PU == false {
                        self.convertTextToSpeech(text: "You are currently performing the push-up exercise")
                        self.isSpeechCall_PU = true
                        self.isSpeechCall_S = false
                        self.isSpeechCall_SP = false
                    }
                }
            }else if (elbow_AngleR >= 100 && elbow_AngleR <= 130) {
                self.pushUp_Position = "Middle"
            }else if (elbow_AngleR >= 30 && elbow_AngleR < 100) {
                self.pushUp_Position = "Down"
            }else{
                self.pushUp_Position = "Deep Down"
            }
            
        }else{
            DispatchQueue.main.async {
                self.textLbl.text = "Please ensure correct alignment of your ankles and knees for proper push-up execution."
            }
        }
      
           
        if self.pushUp_Position == "Up"{
            if ((shoulder_AngleL >= 50 && shoulder_AngleL <= 70)
                || (shoulder_AngleR >= 50 && shoulder_AngleR <= 70)) {
                
             
                DispatchQueue.main.async {
                    self.textLbl.text = "Maintain an upright position with your shoulders aligned. \(self.properCount_PU)"
                }
                if properCount_PU == "1"{
                    self.pushUp_Count += 1
                    DispatchQueue.main.async {
                        self.actionLabel.text = "Push-Ups: \(self.pushUp_Count)"
                    }
                    countStore()
                    UserDefaults.standard.set(pushUp_Count, forKey: "pushUp_Count")
                    properCount_PU = ""
                }else{
                    properCount_PU = ""
                }
            }else{
                DispatchQueue.main.async {
                    self.textLbl.text = "Please maintain proper shoulder position for effective push-ups."
                }
            }
            
        }else if self.pushUp_Position == "Middle"{
            if ((shoulder_AngleL >= 30 && shoulder_AngleL <= 40)
                || (shoulder_AngleR >= 30 && shoulder_AngleR <= 40)) {
                DispatchQueue.main.async {
                    self.textLbl.text = "Maintain a stable position with your shoulders. \(self.properCount_PU)"
                }
            }else{
                DispatchQueue.main.async {
                    self.textLbl.text = "Please maintain proper shoulder position for effective push-ups."
                }
            }
            
        }else if self.pushUp_Position == "Down"{
            if (shoulder_AngleL < 40 || shoulder_AngleR < 40) {
                DispatchQueue.main.async {
                    self.textLbl.text = "Keep your shoulders lower for effective push-ups. \(self.properCount_PU)"
                }
                if properCount_PU == ""{
                    properCount_PU = "1"
                }else{
                    properCount_PU = "1"
                }
            }else{
                properCount_PU = "1"
                DispatchQueue.main.async {
                    self.textLbl.text = "Get ready for the next repetition. You're doing great!"
                }
            }
            
        }else{
            DispatchQueue.main.async {
                self.textLbl.text = "Maintain a controlled downward position during push-ups."
            }
        }
    }
    
    func shoulderPress(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
        guard let shoulderR = bodyParts[.rightShoulder]?.location,
              let shoulderL = bodyParts[.leftShoulder]?.location,
              let hipR = bodyParts[.rightHip]?.location,
              let hipL = bodyParts[.leftHip]?.location,
              let elbowR = bodyParts[.rightElbow]?.location,
              let elbowL = bodyParts[.leftElbow]?.location,
              let wristR = bodyParts[.rightWrist]?.location,
              let wristL = bodyParts[.leftWrist]?.location,
              let kneeR = bodyParts[.rightKnee]?.location,
              let kneeL = bodyParts[.leftKnee]?.location else {
            return
        }
        
        
        let elbow_angleR = calculateAngle(bodyPart1: shoulderR, bodyPart2: elbowR, bodyPart3: wristR) ?? 0
        let elbow_angleL = calculateAngle(bodyPart1: shoulderL, bodyPart2: elbowL, bodyPart3: wristL) ?? 0
        
        let hip_angleR = calculateAngle(bodyPart1: shoulderR, bodyPart2: hipR, bodyPart3: kneeR) ?? 0
        let hip_angleL = calculateAngle(bodyPart1: shoulderL, bodyPart2: hipL, bodyPart3: kneeL) ?? 0
        
        let shoulder_angleL = calculateAngle(bodyPart1: elbowL, bodyPart2: shoulderL, bodyPart3: hipL) ?? 0
        let shoulder_angleR = calculateAngle(bodyPart1: elbowR, bodyPart2: shoulderR, bodyPart3: hipR) ?? 0
        
      
        print("angle hip: \(hip_angleL) \(hip_angleR) shoulder: \(shoulder_angleL) \(shoulder_angleR) elbow:  \(elbow_angleL) \(elbow_angleR)")
        
        
        if (shoulder_angleL < 90 || shoulder_angleR < 90) {
            DispatchQueue.main.async {
                self.actionLabel.text = "Shoulder Press: \(self.shoulderPressCount)"
                if self.isSpeechCall_SP == false {
                    self.convertTextToSpeech(text: "You are currently performing the Shoulder Press exercise. Keep up the good work!")
                    self.isSpeechCall_SP = true
                    self.isSpeechCall_PU = false
                    self.isSpeechCall_S = false
                }
            }
             arm_Position = "down"
        }else if ((shoulder_angleL <= 130 && shoulder_angleL >= 90)
                  || (shoulder_angleR <= 130 && shoulder_angleR >= 90)) {
            arm_Position = "middle"
        }else if (shoulder_angleL > 130 || shoulder_angleR > 130) {
            arm_Position = "up"
        }
        
        
        
        if ((hip_angleR <= 160 && hip_angleR >= 90)
            && (hip_angleL <= 160 && hip_angleL >= 90)) {
            
            if arm_Position == "up" {
                
                DispatchQueue.main.async {
                    self.textLbl.text = "Maintain proper form by keeping your arms aligned and lifting them overhead. \(self.properCount_SP)"
                }
                if (elbow_angleL > 120 && elbow_angleR > 120) {
                    if properCount_SP == "0" {
                        properCount_SP = "1"
                    }else {
                        if properCount_SP == "" {
                            DispatchQueue.main.async {
                                self.textLbl.text = "Ensure correct body alignment and form for the shoulder press exercise."
                            }
                        }else{
                            //
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.textLbl.text = "Please correct the angle of your elbows for proper execution of the shoulder press."
                    }
                }
                
            }else if arm_Position == "middle" {
                
                DispatchQueue.main.async {
                    self.textLbl.text = "Maintain the proper arm position at shoulder height. \(self.properCount_SP)"
                }
                if properCount_SP == "" {
                    properCount_SP = "0"
                }else{
                    if properCount_SP == "1" {
                        if ((elbow_angleL > 80 && elbow_angleL <= 120)
                            && (elbow_angleR > 80 && elbow_angleR <= 120)) {
                            
                            shoulderPressCount += 1
                            DispatchQueue.main.async {
                                self.actionLabel.text = "Shoulder Press: \(self.shoulderPressCount)"
                            }
                            countStore()
                            UserDefaults.standard.set(shoulderPressCount, forKey: "shoulderPressCount")
                            properCount_SP = "2"
                        }else{
                            DispatchQueue.main.async {
                                self.textLbl.text =  "Please correct the alignment of your arms for proper execution of the shoulder press."
                            }
                        }
                    }else{
                        //
                    }
                }
                
            }else if arm_Position == "down" {
                properCount_SP = ""
                DispatchQueue.main.async {
                    self.textLbl.text = "Prepare yourself for the upcoming repetition as we dive into the shoulder press exercise."
                }
                
            }else {
                DispatchQueue.main.async {
                    self.textLbl.text = "Please correct the alignment of your hips for proper execution of the shoulder press."
                }
            }
        }else{
            DispatchQueue.main.async {
                self.textLbl.text = "Please correct the alignment of your hips for proper execution of the shoulder press."
            }
        }
    }
}



extension MainViewController {
    func  all(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
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
        
        
        
        
        if (hip_AngleL > 150 || hip_AngleR > 150) {
            if (shoulder_AngleL < 80 || shoulder_AngleR < 80) {
 //Push-Ups
                self.pushUps(bodyParts: self.bodyParts)
               
            }else if ((shoulder_AngleL >= 80 && shoulder_AngleL <= 140)
                      || (shoulder_AngleR >= 80 && shoulder_AngleR <= 140)) {
//Squat
                self.squats(bodyParts: self.bodyParts)
                
            }else{
                DispatchQueue.main.async {
                    self.textLbl.text = "Nothing..SP"
                }
            }
       }else  if ((hip_AngleL >= 80 && hip_AngleL <= 120)
                  || (hip_AngleR >= 80 && hip_AngleR <= 120)) {
            
            if ((shoulder_AngleL > 140 || shoulder_AngleR > 140)
                || (shoulder_AngleL >= 80 && shoulder_AngleL <= 140)
                || (shoulder_AngleR >= 80 && shoulder_AngleR <= 140)
                || (shoulder_AngleL < 80 || shoulder_AngleR < 80)) {
//Shoulder-Press
                self.shoulderPress(bodyParts: self.bodyParts)
                
              
                
            }else{
                DispatchQueue.main.async {
                    self.textLbl.text = "Not..Shoulder-Press"
                }
            }
        }else{
            DispatchQueue.main.async {
                self.textLbl.text = "No exercise detected.."
            }
        }
    }

}


extension MainViewController{
    func calculateDistanceToFloor(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) -> CGFloat? {
        guard let wristL = bodyParts[.leftWrist]?.location,
              let wristR = bodyParts[.rightWrist]?.location,
              let ankleL = bodyParts[.leftAnkle]?.location,
              let ankleR = bodyParts[.rightAnkle]?.location else {
         return nil
        }
        // Assuming the floor is parallel to the y-axis
        // Calculate the average y-coordinate of the ankles
        let averageAnkleY = (ankleL.y + ankleR.y) / 2
        
        // Calculate the average y-coordinate of the hips
        let averageHipY = (wristL.y + wristR.y) / 2
        
        // Calculate the distance between the floor and the hip
        let distanceToFloor = averageHipY - averageAnkleY
        
        return distanceToFloor
    }
}


extension MainViewController {
    func  ResetTheAllFucntion(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
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
        
      /*
                                    Squat                   push-ups            Shoulder press
       Hip       : Down:-          80-110                   170-180                 90-110
                   Middle:-        120-140                  160-180                 90-110
                   Up:-            150-180                  160-180                 90-120
       
       Shoulder  : Down:-          110-130                  10-40                    70-90
                   Middle:-        110-120                  20-50                   90-110
                   Up:-            110-120                  50-60                   150-170
       
       Elbow     : Down:-          0-20                     60-90                   70-90
                   Middle:-        10-20                    80-120                  80-110
                   Up:-            20-30                    150-170                 130-140
       
       HEW       : Down:-          40-50                    120-180                 130-150
                   Middle:-        50-60                    110-150                 130-150
                   Up:-            50-70                    100-110                 140-150
       
       Knee      : Down:-          80-110                   170-180                 90-120
                   Middle:-        110-130                  150-180                 90-120
                   Up:-            170-180                  160-180                 90-120
       
       */
        // Check the angles and call the appropriate functions
     
/// - Down
        /*
         down :  80-120 sq      110-130     0-50    0-90       80 -110
                 160-180 pu     10-40       50-80   120-180     170-180
                 90-120  sp     70-90       60-80   130-150     90-120
         */
         
   
         if (hip_AngleR > 160 || hip_AngleL > 160) {
                if (shoulder_AngleR < 40 || shoulder_AngleL < 40) {
                    if (elbow_AngleR >= 50 && elbow_AngleR <= 80) || (elbow_AngleL >= 50 && elbow_AngleL <= 80) {
                            if (angle_HEW_R > 120 || angle_HEW_L > 120) {
                                if (knee_AngleR >= 170 || knee_AngleL >= 170) {
                                    /// push ups
//                                    self.pushUps(bodyParts: self.bodyParts)
                                    DispatchQueue.main.async {
                                        self.textLbl.text = "Down - push ups"
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
         }else if (hip_AngleR <= 120) || (hip_AngleL <= 120) {
                if (shoulder_AngleR >= 110 && shoulder_AngleR <=  130) || (shoulder_AngleL >= 110 && shoulder_AngleL <=  130) {
                    if (elbow_AngleR < 50 || elbow_AngleL < 50) {
                        if (angle_HEW_R < 90 || angle_HEW_L < 90) {
                            if (knee_AngleR >= 80 && knee_AngleR <= 150) || (knee_AngleL >= 80 && knee_AngleL <= 150) {
                                ///  squat
                                  self.squats(bodyParts: self.bodyParts)
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
                }else if (shoulder_AngleR >= 70 && shoulder_AngleR <= 90) || (shoulder_AngleL >= 70 && shoulder_AngleL <= 90) {
                    if (elbow_AngleR >= 60 && elbow_AngleR <= 80) || (elbow_AngleL >= 60 && elbow_AngleL <= 80) {
                         if (angle_HEW_R >= 130 || angle_HEW_L >= 130) {
                             if (knee_AngleR >= 90 && knee_AngleR <= 120) || (knee_AngleL >= 90 && knee_AngleL <= 120) {
                                    /// shoulder press
                                  self.shoulderPress(bodyParts: self.bodyParts)
                                 return
                             }else{
                                 //knne
                             }
                         }else{
                             //HEW
                         }
                    }else{
                        //elbiw
                    }
                }
             else{
                 //shoulder
             }
         }else if (hip_AngleR > 80 && hip_AngleR < 90) || (hip_AngleL > 80 && hip_AngleL < 90) {
             if (shoulder_AngleR >= 110 && shoulder_AngleR <= 130) || (shoulder_AngleL >= 110 && shoulder_AngleL <= 130) {
                 if (elbow_AngleR < 50 || elbow_AngleL < 50) {
                     if (angle_HEW_R < 90 || angle_HEW_L < 90) {
                         if (knee_AngleR >= 80 && knee_AngleR <= 150) || (knee_AngleL >= 80 && knee_AngleL <= 150) {
                             ///  squat
                                  self.squats(bodyParts: self.bodyParts)
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
             //Hip
         }
         
  
/// -  Middle
        /*
         middle:    120-150     110-130    0-50       0-90      110-160
                    160-180     20-50      80-150     110-150    150-180
                    90-120      90-150     80-130     130-150    90-120
         */
         if (hip_AngleR > 160 || hip_AngleL > 160) {
            if (shoulder_AngleR >= 20 && shoulder_AngleR <= 50) || (shoulder_AngleL >= 20 && shoulder_AngleL <= 50) {
                if (elbow_AngleR >= 80 && elbow_AngleR <= 150) || (elbow_AngleL >= 80 && elbow_AngleL <= 150) {
                    if (angle_HEW_R >= 100 && angle_HEW_R <= 150) || (angle_HEW_L >= 100 && angle_HEW_L <= 150) {
                        if (knee_AngleR >= 150 || knee_AngleL >= 150) {
                            /// push ups
                            DispatchQueue.main.async {
                                self.textLbl.text = "Middle - Push ups"
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
         }else if (hip_AngleR >= 120 && hip_AngleR <= 150) || (hip_AngleL >= 120 && hip_AngleL <= 150) {
             if (shoulder_AngleR >= 110 && shoulder_AngleR <= 130) || (shoulder_AngleL >= 110 && shoulder_AngleL <= 130) {
                if (elbow_AngleR < 50 || elbow_AngleL < 50) {
                    if (angle_HEW_R <= 90 || angle_HEW_L <= 90) {
                        if (knee_AngleR >= 110 && knee_AngleR <= 160) || (knee_AngleL >= 110 && knee_AngleL <= 160) {
                            ///  squat
                            self.squats(bodyParts: self.bodyParts)
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
         }else if (hip_AngleR >= 90 && hip_AngleR <= 120) || (hip_AngleL >= 90 && hip_AngleL <= 120) {
             if (shoulder_AngleR >= 90 && shoulder_AngleR <= 150) || (shoulder_AngleL >= 90 && shoulder_AngleL <= 150) {
                if (elbow_AngleR >= 80 && elbow_AngleR < 130) || (elbow_AngleL >= 80 && elbow_AngleL < 130) {
                    if (angle_HEW_R >= 130 || angle_HEW_L >= 130) {
                        if (knee_AngleR >= 90 && knee_AngleR <= 120) || (knee_AngleL >= 90 && knee_AngleL <= 120) {
                            ///  shoulder press
                           self.shoulderPress(bodyParts: self.bodyParts)
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
             //Hip
         }
     
        
        
 /// -  up
        /*
         up :
                150-180     110-130      0-50       0-90       160-180
                160-180     50-60       150-170     100-110      160-180
                90-120      150-170     130-180     130-150       90-120
         */
         if (hip_AngleR > 160 || hip_AngleL > 160) {
                if (shoulder_AngleR >= 110 && shoulder_AngleR <= 130) || (shoulder_AngleL >= 40 && shoulder_AngleL <= 130) {
                    if (elbow_AngleR < 50 || elbow_AngleL < 50) {
                        if (angle_HEW_R <= 90 || angle_HEW_L <= 90) {
                            if (knee_AngleR > 160 || knee_AngleL > 160) {
                                /// squat
                                self.squats(bodyParts: self.bodyParts)
                                return
                            }
                        }
                    }
                }else if (shoulder_AngleR >= 50 && shoulder_AngleR <= 60) || (shoulder_AngleL >= 50 && shoulder_AngleL <= 60) {
                    if (elbow_AngleR > 150 || elbow_AngleL > 150) {
                        if (angle_HEW_R >= 100 && angle_HEW_R <= 110) || (angle_HEW_L >= 100 && angle_HEW_L <= 110) {
                            if (knee_AngleR > 160 || knee_AngleL > 160) {
                                /// push-ups
                                DispatchQueue.main.async {
                                   self.textLbl.text = "Up - Push-ups"
                                }
                                return
                            }
                        }
                    }
                }
         }else if (hip_AngleR >= 150 && hip_AngleR < 160) || (hip_AngleL >= 150 && hip_AngleL < 160) {
                 if (shoulder_AngleR >= 40 && shoulder_AngleR <= 130) || (shoulder_AngleL >= 40 && shoulder_AngleL <= 130) {
                     if (elbow_AngleR < 50 || elbow_AngleL < 50) {
                         if (angle_HEW_R <= 90 || angle_HEW_L <= 90) {
                             if (knee_AngleR > 160 || knee_AngleL > 160) {
                                 /// squat
                                 self.squats(bodyParts: self.bodyParts)
                                 return
                             }
                         }
                     }
                 }
         }else if (hip_AngleR >= 90 && hip_AngleR <= 120) || (hip_AngleL >= 90 && hip_AngleL <= 120) {
                 if shoulder_AngleR >= 150 || shoulder_AngleL >= 150 {
                    if (elbow_AngleR >= 130 || elbow_AngleL <= 130) {
                        if (angle_HEW_R >= 130 || angle_HEW_L >= 130) {
                             if (knee_AngleR >= 90 && knee_AngleR <= 120) || (knee_AngleL >= 90 && knee_AngleL <= 120) {
                                ///  shoulder press
                                 self.shoulderPress(bodyParts: self.bodyParts)
                                 return
                             }
                        }
                    }
                 }
         }
         
         
        
    }
}
