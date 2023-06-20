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
class MainViewController: UIViewController {


    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var labelStack: UIStackView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var summaryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var toastView: UIView!

    var videoCapture: VideoCapture!
    var videoProcessingChain: VideoProcessingChain!
    var actionFrameCounts = [String: Int]()
    var bodyParts = [VNHumanBodyPoseObservation.JointName : VNRecognizedPoint]()
    
    var squat_Count = 0
    var squat_Up = true
    var sqaut_Down = false
    var squat_Position = "down"
    
    var pushUp_Count = 0
    var push_Up = true
    var push_Down = false
    var pushUp_Position = "down"
    var selectedExercise = 0
    var index_Ex = 0
    
    private lazy var annotationOverlayView: UIView = {
      precondition(isViewLoaded)
      let annotationOverlayView = UIView(frame: .zero)
      annotationOverlayView.translatesAutoresizingMaskIntoConstraints = false
      annotationOverlayView.clipsToBounds = true
      return annotationOverlayView
    }()
    
}

// MARK: - View Controller Events
extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        toastView.isHidden = true
        index_Ex = selectedExercise
       print("selectedExercise \(index_Ex)")
        UIApplication.shared.isIdleTimerDisabled = true
        UIApplication.shared.isIdleTimerDisabled = true

        let views = [labelStack, buttonStack, cameraButton, summaryButton]
            views.forEach { view in
            view?.layer.cornerRadius = 10
            view?.overrideUserInterfaceStyle = .dark
        }

        videoProcessingChain = VideoProcessingChain()
        
        videoProcessingChain.delegate = self

        videoCapture = VideoCapture()
        videoCapture.delegate = self

        updateUILabelsWithPrediction(.startingPrediction)
        
        let synth = AVSpeechSynthesizer()
        let myUtterance = AVSpeechUtterance(string: "Please Stand Up ")
        myUtterance.rate = 0.4
        synth.speak(myUtterance)
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
}

// MARK: - Video Capture Delegate
extension MainViewController: VideoCaptureDelegate {
    func videoCapture(_ videoCapture: VideoCapture,didCreate framePublisher: FramePublisher) {
        updateUILabelsWithPrediction(.startingPrediction)
        videoProcessingChain.upstreamFramePublisher = framePublisher
    }
}

// MARK: - video-processing chain Delegate
extension MainViewController: VideoProcessingChainDelegate {
    func videoProcessingChain(_ chain: VideoProcessingChain,
                              didPredict actionPrediction: ActionPrediction,
                              for frameCount: Int) {
        if actionPrediction.isModelLabel {
            addFrameCount(frameCount, to: actionPrediction.label)
        }
        updateUILabelsWithPrediction(actionPrediction)
    }

    /// - Parameters:
    ///   - chain: A video-processing chain.
    ///   - poses: A `Pose` array.
    ///   - frame: A video frame as a `CGImage`.
    ///
    func videoProcessingChain(_ chain: VideoProcessingChain,didDetect poses: [PoseS]?,in frame: CGImage) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.drawPoses(poses, onto: frame)
            
            guard let shoulder =       self.bodyParts[.rightShoulder]?.location,
                  let elbow = self.bodyParts[.rightElbow]?.location,
                  let wrist = self.bodyParts[.rightWrist]?.location else {
                return
            }
            
            print("selectedExercise \(self.index_Ex)")
            if self.index_Ex == 0 {
                self.countSquats(bodyParts: self.bodyParts)
            }else{
                self.countPushUps(bodyParts: self.bodyParts)
            }
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
        let confidenceString = prediction.confidenceString ?? "Observing..."
        DispatchQueue.main.async {
            self.confidenceLabel.text = confidenceString
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
                
                let shoulder = bodyParts[.rightShoulder]!.location
                let knee = bodyParts[.rightKnee]!.location
                
                let difference = calculateDifference(shoulder: shoulder, hip: knee)
                print("Difference between shoulder and hip: \(difference)")
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

            // Call countSquats() with the recognized body parts
//            countSquats(bodyParts: bodyParts)
        }
    }
    func countPushUps(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
        guard let rightShoulder = bodyParts[.rightShoulder]?.location,
              let leftShoulder = bodyParts[.leftShoulder]?.location,
              let rightElbow = bodyParts[.rightElbow]?.location,
              let leftElbow = bodyParts[.leftElbow]?.location,
              let leftAnkle = bodyParts[.leftAnkle]?.location,
              let rightAnkle = bodyParts[.rightAnkle]?.location,
              let rightWrist = bodyParts[.rightWrist]?.location,
              let leftWrist = bodyParts[.leftWrist]?.location else {
            return
        }
        
/// - Right ( Wrist - Elbow - Shoulder )
        let rightSEVector = CGVector(dx: rightElbow.x - rightShoulder.x, dy: rightElbow.y - rightShoulder.y)
        let rightEWVector = CGVector(dx: rightWrist.x - rightElbow.x, dy: rightWrist.y - rightElbow.y)
        let rightSEAngle = atan2(rightSEVector.dy, rightSEVector.dx)
        let rightEWAngle = atan2(rightEWVector.dy, rightEWVector.dx)
        
        let rightAngleDegrees = abs(Int((rightSEAngle - rightEWAngle) * 180 / .pi))
        var isRightPUPosition = (rightAngleDegrees < 30) // Adjust the angle threshold as needed
        

/// - Left ( Wrist - Elbow - Shoulder )
        let leftSEVector = CGVector(dx: leftElbow.x - leftShoulder.x, dy: leftElbow.y - leftShoulder.y)
        let leftEWVector = CGVector(dx: leftWrist.x - leftElbow.x, dy: leftWrist.y - leftElbow.y)
        let leftSEAngle = atan2(leftSEVector.dy, leftSEVector.dx)
        let leftEWAngle = atan2(leftEWVector.dy, leftEWVector.dx)
        
        let leftAngleDegrees = abs(Int((leftSEAngle - leftEWAngle) * 180 / .pi))
        let isLeftPUPosition = (leftAngleDegrees < 30) // Adjust the angle threshold as needed
        
        print("isRightPUPosition Right \(isRightPUPosition)  \(rightAngleDegrees) Left \(isLeftPUPosition)  \(leftAngleDegrees) \(isRightPUPosition)")
        
        // Calculate the distance between left shoulder and right shoulder
          
       
        print("Shoulder distance: \(rightAngleDegrees) \(leftAngleDegrees)")
        
        
        
        if ((rightAngleDegrees > 150 || leftAngleDegrees > 150) && (pushUp_Position == "down")){
            if (pushUp_Count == 0){
                DispatchQueue.main.async{
                    self.toastView.isHidden = false
                    self.textLbl.text = "Please be in the position of push up"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.toastView.isHidden = true
                    self.textLbl.text = ""
                }
                
            }
        }else if rightAngleDegrees < 30 && leftAngleDegrees < 30 && self.pushUp_Count == 0{
            self.pushUp_Position = "up"
        }else{
            if ((rightAngleDegrees > 30 || leftAngleDegrees > 30)){
                if (pushUp_Position == "up" && push_Up && !push_Down){
                    pushUp_Count += 1
                    push_Up = false
                    push_Down = true
                    pushUp_Position = "down"
                    
                DispatchQueue.main.async {
                    self.actionLabel.text = "Push-up : \(self.pushUp_Count)"
                }
            }
            }else {
                push_Up = true
                push_Down = false
                pushUp_Position = "up"
        }
        }
    }

    
    func countSquats(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
          guard let rightKnee = bodyParts[.rightKnee]?.location,
                let leftKnee = bodyParts[.leftKnee]?.location,
                let rightKnee = bodyParts[.rightKnee]?.location,
                let rightHip = bodyParts[.rightHip]?.location,
                let rightAnkle = bodyParts[.rightAnkle]?.location,
                let leftAnkle = bodyParts[.leftAnkle]?.location,
                let nose = bodyParts[.nose]?.location else {
            return
        }
        let firstAngle = atan2(rightHip.y - rightKnee.y, rightHip.x - rightKnee.x)
        let secondAngle = atan2(rightAnkle.y - rightKnee.y, rightAnkle.x - rightKnee.x)
        var angleDiffRadians = firstAngle - secondAngle
        while angleDiffRadians < 0 {
            angleDiffRadians += CGFloat(2 * Double.pi)
        }
        let angleDiffDegrees = Int(angleDiffRadians * 180 / .pi)
        let RS: Float = Float(nose.y)
        let LS: Float = Float(rightAnkle.y)
        let shoulderRint = Int(RS * 100)
        let shoulderLint = Int(LS * 100)
        let hipHeight = rightHip.y
        let kneeHeight = rightKnee.y
        
        let shoulderR = bodyParts[.rightShoulder]!.location
        let shoulderL = bodyParts[.leftShoulder]!.location
        let elbowR = bodyParts[.rightElbow]!.location
        let elbowL = bodyParts[.leftElbow]!.location
        let wristR = bodyParts[.rightWrist]!.location
        let wristL = bodyParts[.leftWrist]!.location
        let leftHip = bodyParts[.leftHip]!.location
        let leftEar = bodyParts[.leftEar]!.location
        let leftShoulder = bodyParts[.leftShoulder]!.location
        
        let shoulderDifference = calculateDifference(shoulder: shoulderL, hip: shoulderR)
        let ankleDifference = calculateDifference(shoulder: leftAnkle, hip: rightAnkle)
        
        let shoulderDiff = Int(shoulderDifference * 100)
        let ankleDiff = Int(ankleDifference * 100)
        let wristRight = Int(wristR.y * 100)
        let wristLeft = Int(wristL.y * 100)
        let shoulderLeft = Int(leftShoulder.y * 100)
        
     
        print("shoulderDiff \(shoulderDiff) ankleDiff \(ankleDiff)")
        
        
        if ((angleDiffDegrees < 150) && (squat_Position == "down")){
            if (squat_Count == 0){
                DispatchQueue.main.async{
                    self.toastView.isHidden = false
                    self.textLbl.text = "Please stand up straight"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.toastView.isHidden = true
                    self.textLbl.text = ""
                    
                }
                DispatchQueue.main.async {
                    if angleDiffDegrees > 150 && self.squat_Count == 0{
                        self.squat_Position = "up"
                    }
                }
            }
        }else if wristRight < 40 || wristLeft < 40 {
            DispatchQueue.main.async {
                self.toastView.isHidden = false
                self.textLbl.text = "Please hold your hands behind your neck"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.toastView.isHidden = true
                self.textLbl.text = ""
            }
        } else if ankleDiff < shoulderDiff {
            DispatchQueue.main.async {
                self.toastView.isHidden = false
                self.textLbl.text = "Please spread your feet apart"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.toastView.isHidden = true
                self.textLbl.text = ""
            }
        } else{
            var currentHeight =  (shoulderRint + shoulderLint)/2 //Judging up and down by shoulder height
            print("`currentHeight` \(currentHeight) angleDiffDegrees \(angleDiffDegrees) ")
            
            if angleDiffDegrees < 150 && currentHeight <= 50 {
                if (squat_Position == "up" && squat_Up && !sqaut_Down) {
                    squat_Count += 1
                    squat_Up = false
                    sqaut_Down = true
                    squat_Position = "down"
                    DispatchQueue.main.async {
                       self.actionLabel.text = "Squats: \(self.squat_Count)"
                    }
                }
            }else {
                squat_Up = true
                sqaut_Down = false
                squat_Position = "up"
            }
        }
        
        let kneeDistance = rightKnee.distance(to: leftKnee)
        let ankleDistance = rightAnkle.distance(to: leftAnkle)
        
    }
    

    

    func transformMatrix() -> CGAffineTransform {
      guard let image = imageView.image else { return CGAffineTransform() }
      let imageViewWidth = imageView.frame.size.width
      let imageViewHeight = imageView.frame.size.height
      let imageWidth = image.size.width
      let imageHeight = image.size.height

      let imageViewAspectRatio = imageViewWidth / imageViewHeight
      let imageAspectRatio = imageWidth / imageHeight
      let scale =
        (imageViewAspectRatio > imageAspectRatio)
        ? imageViewHeight / imageHeight : imageViewWidth / imageWidth

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
