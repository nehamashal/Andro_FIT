//
//  ScanFaceViewController.swift
//  Andro Fit App
//
//  Created by Neha on 26/07/23.
//

import UIKit

import ARKit
import MLKit
import TensorFlowLite
import Alamofire
import AVFoundation

var faceDictionary = [String : Array<Float>]()

class ScanFaceViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var faceeImg:UIImageView!
    @IBOutlet weak var faceLabel:UILabel!
    @IBOutlet weak var registerBtn:UIView!
    @IBOutlet weak var vectorImage:UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var progressBarTimer: Timer!
    var isRunning = false
    
    
    var isPhotoProcessed = true
    let sceneView = ARSCNView()
    var faceImage = UIImage()
    let maxRGBValue: Float32 = 255.0
    var DistanceDic = [String : Double]()
    var interpreter: Interpreter? = nil
    var faceDetector:FaceDetector? = nil
    var latestFaceVector: UnsafeMutableBufferPointer<Float32>? = nil
    var currentFaceVector: UnsafeMutableBufferPointer<Float32>? = nil
    var apiRegisterNewUserResponse:ApiUserDetailResponse?
    var player: AVAudioPlayer!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerBtn.isHidden = true
        let frame = CGRect(x:0, y: 0, width: self.cameraView.frame.size.width, height: self.cameraView.bounds.height)
        sceneView.frame = frame
        self.cameraView.addSubview(sceneView)
        
        let faceDetectorOption: FaceDetectorOptions = {
            let option = FaceDetectorOptions()
            option.contourMode = .none
            option.performanceMode = .accurate
            return option
        }()
        faceDetector = FaceDetector.faceDetector(options: faceDetectorOption)
        self.startSceneKit()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatePhotoProcessing(notification:)), name: Notification.Name("updatePhotoProcessing"), object: nil)
    }
    @objc func updatePhotoProcessing(notification: Notification){
        self.isPhotoProcessed = true
        self.sceneView.delegate = self
    }
    func startSceneKit(){
        sceneView.delegate = self
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    override func viewWillAppear(_ animated: Bool) {
        initInterpreter()
        self.hitApiGetAllUsers()
    }
    func captureImage() -> UIImage {        
        self.startProgressBar()
        guard let pixelBuffer = self.sceneView.session.currentFrame?.capturedImage else { return UIImage() }
        print("Image Captured")
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let faceImg = UIImage(ciImage: ciImage,scale: 1.0,orientation: .right).fixOrientation()
        self.faceeImg.image = faceImg
        ScanFaceViewController.playSounds(audioName:"cyanping")
        return faceImg
    }
    
    @IBAction func actionDetectImage(_ sender:UIButton){
        print("actionDetectImage Button pressed®")
//        if self.faceImage == UIImage() {
//            return
//        }else {
//            self.processImage(uiImage: self.faceImage)
//        }
//        let faceImage = self.captureImage()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.processImage(uiImage: faceImage)
//        }
    }
    @IBAction func actionAddFace(_ sender:UIButton){
        self.sceneView.delegate = nil
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterNewfaceViewController") as! RegisterNewfaceViewController
            vc.cropfaceImage = self.faceImage
            vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }

}
extension ScanFaceViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        guard let device = sceneView.device else {
            return nil
        }
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)
            node.geometry?.firstMaterial?.fillMode = .lines
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
                return
        }
        faceGeometry.update(from: faceAnchor.geometry)
        DispatchQueue.main.async {
            if self.isPhotoProcessed {
                self.isPhotoProcessed = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.faceImage = self.captureImage()
                    self.processImage(uiImage: self.faceImage)
                }
                
            }
            
        }
        
    }
    
    
}
extension ScanFaceViewController {
    
    
    func hitApiGetAllUsers(){
          let url = "http://3.232.30.130:3006/getusers"
          let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
          let headers: HTTPHeaders = ["Authorization": "Bearer " + accessToken]
          print("hitApiGetAllUsers parameters \(accessToken) and url \(url)")
          self.apiRegisterNewUserResponse = nil
          AF.request( URL(string: url)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
              .validate()
              .responseData(completionHandler: {(response) in
             
                  switch(response.result){
                      case .success(_):
                          print("hitApiGetAllUsers \(response)")
                          do {
                              guard let data = response.data else {return}
                              let decoder = JSONDecoder()
                              self.apiRegisterNewUserResponse = try? decoder.decode(ApiUserDetailResponse.self, from: data)
                              
                              print("hitApiGetAllUsers,\(self.apiRegisterNewUserResponse)")
                              
                              if self.apiRegisterNewUserResponse?.status == true {
                                  faceDictionary.removeAll()
                                  self.apiRegisterNewUserResponse?.data?.forEach({ faceData in
                                      let vector = self.stringToFloatBufferPointer(faceData.faceVector ?? "")
                                      
                                      let vector1 = self.convertStringToArrayOfFloat(faceData.faceVector ?? "")
                                      faceDictionary[faceData.userName ?? ""] = vector1
                                  })
                              }
                          }catch {
                              
                          }
                          //then you can access your result
                      case .failure(let error):
                          print("hitApiSendOTP is \(error.localizedDescription)")
                      }
                  })
          }
    
    func convertStringToArrayOfFloat(_ inputString: String) -> [Float] {
        let stringValues = inputString.split(separator: " ")
        var floatArray: [Float] = []
        
        for stringValue in stringValues {
            if let floatValue = Float(stringValue) {
                floatArray.append(floatValue)
            } else {
                // Handle invalid or non-convertible values if needed
                print("Error: Invalid number in the input string.")
            }
        }
        
        return floatArray
    }

    func stringToFloatBufferPointer(_ inputString: String) -> UnsafeMutableBufferPointer<Float32>? {
        let floatStrings = inputString.split(separator: " ")
        var floatValues = [Float]()
        for floatString in floatStrings {
            if let floatValue = Float32(floatString) {
                floatValues.append(floatValue)
            } else {
                // Invalid float value in the input string
                return nil
            }
        }
        let bufferPointer = UnsafeMutableBufferPointer<Float32>.allocate(capacity: floatValues.count)
        let pointOne = bufferPointer.initialize(from: floatValues)

        return bufferPointer
    }
    func initInterpreter() {
        DispatchQueue.global(qos: .background).async {
            let localModelFile = (name: "mobile_face_net", type: "tflite")
            let localModelFilePath = Bundle.main.path(
                forResource: localModelFile.name,
                ofType: localModelFile.type
            )
            do {
                self.interpreter = try Interpreter.init(modelPath: localModelFilePath!)
                try self.interpreter?.allocateTensors()
                print("allocated tensors")
            } catch {
                print("could not get local model")
            }
        }
    }
    
    func bufferPointerToString(bufferPointer: UnsafeMutableBufferPointer<Float32>?) -> String {
        guard let bufferPointer = bufferPointer else {
            return "Buffer pointer is nil."
        }
        var stringRepresentation = ""
        for floatElement in bufferPointer {
            stringRepresentation.append("\(floatElement) ")
        }
        // Remove the trailing space from the final string.
        if !stringRepresentation.isEmpty {
            stringRepresentation.removeLast()
        }
        return stringRepresentation
    }
    
    func processImage(uiImage: UIImage) {
        
        faceDetector?.process(getVisionImage(from: uiImage)) { faces, error in
            guard error == nil, let faces = faces, !faces.isEmpty else {
                print("Error + \(error.debugDescription)")
                return
            }
            print("Face Detected \(faces.count)")
            // Faces detected
            //self.processResult(faces, uiImage)
            let localModelFile = (name: "mobile_face_net", type: "tflite")
            let localModelFilePath = Bundle.main.path(
                forResource: localModelFile.name,
                ofType: localModelFile.type
            )
           
//            if let faceCrop = uiImage.cgImage?.cropping(to: faces[0].frame) {
//                if let cgimage = ImageUtils.resizeWithCoreGraphics(cgImage: faceCrop, newSize: CGSize(width: 112, height: 112)) {
//                    DispatchQueue.main.async {
//                        self.vectorImage.image = UIImage(cgImage: cgimage)
//                    }
//                }
//            }
            if let faceMatcher = FaceMatcher(modelPath: localModelFilePath ?? "") {
                if let image = uiImage.cgImage {
                    self.vectorImage.image = UIImage(cgImage: image)
                    if let matchedName = faceMatcher.matchFace(image) {
                        print("Detected face Name: \(matchedName)")
                    } else {
                        print("User not found")
                        
                        DispatchQueue.main.async {
                            self.registerBtn.isHidden = false
                            self.sceneView.delegate = nil
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserNotFoundVC") as! UserNotFoundVC
                            vc.modalPresentationStyle = .overCurrentContext
                            self.present(vc, animated: true)
                        }
                    }
                    
                }
            }
        }
    }
    func getVisionImage(from uiImage: UIImage) -> VisionImage {
        let visionImage = VisionImage(image: uiImage)
        visionImage.orientation = uiImage.imageOrientation
        return visionImage
    }
    
    func processResult(_ faces: [Face], _ uiImage: UIImage) {
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2.0) {
            var frames = [FrameWithLabel]()
            for (index, face) in faces.enumerated() {
                var label = "\(index + 1)"
                if let faceCrop = uiImage.cgImage?.cropping(to: face.frame) {
                if let image = ImageUtils.resizeWithCoreGraphics(cgImage: faceCrop, newSize: CGSize(width: 112, height: 112)) {
                    DispatchQueue.main.async {
                        self.vectorImage.image = UIImage(cgImage: image)
                    }
                    guard let context = CGContext(
                        data: nil,
                        width: image.width, height: image.height,
                        bitsPerComponent: 8, bytesPerRow: image.width * 4,
                        space: CGColorSpaceCreateDeviceRGB(),
                        bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
                    ) else {
                        return
                    }
                    let croppedFace = UIImage(cgImage: image)
                    
                    context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
                    guard let imageData = context.data else { return }
                    
                    var inputData = Data()
                    for row in 0 ..< 112 {
                        for col in 0 ..< 112 {
                            let offset = 4 * (row * context.width + col)
                            // (Ignore offset 0, the unused alpha channel)
                            let red = imageData.load(fromByteOffset: offset+1, as: UInt8.self)
                            let green = imageData.load(fromByteOffset: offset+2, as: UInt8.self)
                            let blue = imageData.load(fromByteOffset: offset+3, as: UInt8.self)
                            
                            // Normalize channel values to [0.0, 1.0]. This requirement varies
                            // by model. For example, some models might require values to be
                            // normalized to the range [-1.0, 1.0] instead, and others might
                            // require fixed-point values or the original bytes.
                            var normalizedRed = Float32(red) / self.maxRGBValue
                            var normalizedGreen = Float32(green) / self.maxRGBValue
                            var normalizedBlue = Float32(blue) / self.maxRGBValue
                            
                            // Append normalized values to Data object in RGB order.
                            let elementSize = MemoryLayout.size(ofValue: normalizedRed)
                            var bytes = [UInt8](repeating: 0, count: elementSize)
                            memcpy(&bytes, &normalizedRed, elementSize)
                            inputData.append(&bytes, count: elementSize)
                            memcpy(&bytes, &normalizedGreen, elementSize)
                            inputData.append(&bytes, count: elementSize)
                            memcpy(&bytes, &normalizedBlue, elementSize)
                            inputData.append(&bytes, count: elementSize)
                        }
                    }
                    do {
                        print("inputData , ", inputData)
                        try self.interpreter?.copy(inputData, toInputAt: 0)
                        try self.interpreter?.invoke()
                        
                        if let output = try self.interpreter?.output(at: 0) {
                            
                            
                            
                            
                            
                            let faceVector = UnsafeMutableBufferPointer<Float32>.allocate(capacity: 192)
                            let shapeSize = output.data//.copyBytes(to: faceVector)
                            
                            
                            print("shapeSize",Array(shapeSize))
                            print("Face vector: \(faceVector.debugDescription)")
                            self.latestFaceVector = faceVector
                            if let name = self.findNearestName(faceVector) {
                                label = name
                                print("Detected face Name \(name)")
                                DispatchQueue.main.async {
                                    self.faceLabel.text = name
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        
                                        //                                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                                        //                                            self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                }
                            }else {
                                print("User not found ")
                                DispatchQueue.main.async {
                                    self.registerBtn.isHidden = false
                                    self.sceneView.delegate = nil
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserNotFoundVC") as! UserNotFoundVC
                                    vc.modalPresentationStyle = .overCurrentContext
                                    self.present(vc, animated: true)
                                }
                            }
                        }
                        try self.interpreter?.allocateTensors()
                    } catch {
                        print("error in recognition \(error.localizedDescription)")
                    }
                  }
                }
                frames.append(FrameWithLabel(frame: face.frame, label: label))
                
            }
        }
    }
    
    func findNearestName(_ faceVector: UnsafeMutableBufferPointer<Float32>) -> String? {
        var nearestName: String? = nil
        let  nearestFaceDistance = Double.infinity
        if (faceDictionary.count > 0) {
            var indexx = 0
            for (name, knownVector) in faceDictionary {
                indexx = indexx + 1
                var distance = Float32(0.0)
                for i in 0 ..< 192 {
                    let diff = faceVector[i] - knownVector[i]
                    distance += (diff * diff)
                }
                
                let finalDistance = sqrt(Double(distance))
                self.DistanceDic[name] = finalDistance
                print("distance ,\(finalDistance) ,  nearest \(nearestFaceDistance)")
                if ((finalDistance < 0.7) && (finalDistance < nearestFaceDistance)) {
                    nearestName = name
                }
                print("index \(indexx)")
            }
        }
        let lowestValue  = DistanceDic.min(by:{$0.value < $1.value})!
        print("lowest value \(lowestValue)")
        return nearestName
    }
    
    class func playSounds(audioName: String) {
        // Load a local sound file
            guard let soundFileURL = Bundle.main.url(
                forResource: audioName,
                withExtension: "mp3"
            ) else {
                return
            }
            
            do {
                // Configure and activate the AVAudioSession
                try AVAudioSession.sharedInstance().setCategory(
                    AVAudioSession.Category.playback
                )

                try AVAudioSession.sharedInstance().setActive(true)

                // Play a sound
                let player = try AVAudioPlayer(
                    contentsOf: soundFileURL
                )

                player.play()
            }
            catch {
                // Handle error
            }
    }
}

//MARK: ProgressBAR
extension ScanFaceViewController {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func startProgressBar(){
        if(isRunning){
            progressBarTimer.invalidate()
        }
        else{
        progressView.progress = 0.0
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
            progressView.progressTintColor = UIColor(hexString: "FEC303")
            progressView.progressViewStyle = .default
        
        }
        isRunning = !isRunning
    }
    @objc func updateProgressView(){
        progressView.progress += 0.1
        progressView.setProgress(progressView.progress, animated: true)
        if(progressView.progress == 1.0)
        {
            progressBarTimer.invalidate()
            isRunning = false
        }
    }
}
