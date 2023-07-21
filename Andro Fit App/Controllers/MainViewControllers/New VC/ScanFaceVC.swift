//
//  ScanFaceVC.swift
//  Andro Fit App
//
//  Created by Neha on 18/07/23.
//

import UIKit
import ARKit
import FaceSDK
import Photos
import AVFoundation

class ScanFaceVC: UIViewController, ARSCNViewDelegate, UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,AVCapturePhotoCaptureDelegate{
    
    @IBOutlet weak var camerView:UIView!
    
    private var firstImage: MatchFacesImage?
    private var secondImage: MatchFacesImage?
       
        
    var frirstImage = UIImageView()
    var ssecoundImg = UIImageView()
    let sceneView = ARSCNView(frame: UIScreen.main.bounds)
    var fDetetct: Bool?
    var imgOutPut: AVCapturePhotoOutput!
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var captureSession =  AVCaptureSession()
    var vdoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get the image that is reviously saved
        
        let categoryIcon = UserDefaults.standard.data(forKey: "profileimg") ?? Data()
        frirstImage.image = UIImage(data: categoryIcon)
        configureDevice()
    }
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            if fDetetct == true {
            }
            else {
                captureSession = AVCaptureSession()
                captureSession.sessionPreset = .photo
                //guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
                
                guard let frontcamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
                    else {
                        print("Unable to access front camera!")
                        return
                }
                do {
                    let input = try AVCaptureDeviceInput(device: frontcamera)
                    //Step 9
                    imgOutPut = AVCapturePhotoOutput()
                    if captureSession.canAddInput(input) && captureSession.canAddOutput(imgOutPut) {
                        captureSession.addInput(input)
                        captureSession.addOutput(imgOutPut)
                        setupLivePreview()
                    }
                }
                catch let error  {
                    print("Error Unable to initialize front camera:  \(error.localizedDescription)")
                }
            }
        }

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.captureSession.stopRunning()
        }

}

//buttios
extension ScanFaceVC {
    @IBAction func startBtn(_ sender:UIButton){
        UserDefaults.standard.set("1", forKey: "isLoggedIn")
        let storyboard : UIStoryboard = StoryboardConstant.home
        let mainTabBarController = storyboard.instantiateViewController(identifier: "HomeMainNAV")
               window?.rootViewController = mainTabBarController
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        
    }
    @IBAction func backBtn(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
//functions
extension ScanFaceVC {
    func setupLivePreview(){
            vdoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            vdoPreviewLayer.videoGravity = .resizeAspectFill
            vdoPreviewLayer.connection?.videoOrientation = .portrait
            camerView.layer.addSublayer(vdoPreviewLayer)
            DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
                self.captureSession.startRunning()
                //Step 13
                DispatchQueue.main.async {
                    self.vdoPreviewLayer.frame = self.camerView.bounds
                    self.camerView.layer.insertSublayer(self.vdoPreviewLayer!, at: 0)
                }
            }
        }
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            
            guard let imageData = photo.fileDataRepresentation()
                else { return }
            
            let detectedImage = UIImage(data: imageData)
            self.ssecoundImg.image = detectedImage
            defer {
                self.matchFace()
            }
            self.captureSession.stopRunning()
            
            
        }
    func matchFace(){
        self.createImageForPosition(firstImage: frirstImage.image, secoundImg: ssecoundImg.image) { firImg, secImg in
                 self.firstImage = firImg
                 self.secondImage = secImg
        }
        guard let firstImage = firstImage, let secondImage = secondImage else {return}
        let request = MatchFacesRequest(images: [firstImage, secondImage])
        
        FaceSDK.service.matchFaces(request, completion: { (response: MatchFacesResponse) in
            
            if let error = response.error {
//                self.similarityLabel.text = "\(error.localizedDescription)"
                self.effectView.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
                return
            }
            if let firstPair = response.results.first {
                let similarity = String(format: "%.5f", firstPair.similarity?.doubleValue ?? 0.0)
                print("Similarity: \(similarity)")
//                self.similarityLabel.text = "Similarity: \(similarity)"
                self.effectView.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            } else {
//                self.similarityLabel.text = "Similarity: no matched pair found"
                self.effectView.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            }
        })
    }
    func activityIndicator(_ title: String) {
              strLabel.removeFromSuperview()
              activityIndicator.removeFromSuperview()
              effectView.removeFromSuperview()
              strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
              strLabel.text = title
              strLabel.font = .systemFont(ofSize: 14, weight: .medium)
              strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
              effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
              effectView.layer.cornerRadius = 15
              effectView.layer.masksToBounds = true
              activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
          self.view.isUserInteractionEnabled = false
              activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
              activityIndicator.startAnimating()
              effectView.contentView.addSubview(activityIndicator)
              effectView.contentView.addSubview(strLabel)
              view.addSubview(effectView)
          }
}

extension ScanFaceVC{
    private func createImageForPosition(firstImage:UIImage?, secoundImg:UIImage?,completion: @escaping (MatchFacesImage?,MatchFacesImage?) -> Void) {
    
                let result = firstImage.map {
                    MatchFacesImage(
                        image: $0,
                        imageType: .printed,
                        detectAll: true
                    )
                }
                let result1 = secoundImg.map {
                    MatchFacesImage(
                        image: $0,
                        imageType: .live,
                        detectAll: true
                    )
                }
             completion(result, result1)
       
    }

}

extension ScanFaceVC : AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
                
                // Scale image to process it faster
                guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
                       debugPrint("unable to get image from sample buffer")
                       return
                   }
                  // self.detectFace(in: frame)
            }
    private func detectFace(in image: CVPixelBuffer) {
           let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request: VNRequest, error: Error?) in
               DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                   if let results = request.results as? [VNFaceObservation], results.count > 0 {
                       print("did detect \(results.count) face(s)")
                       let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                       self.imgOutPut.capturePhoto(with: settings, delegate: self)
                       self.activityIndicator("Processing")
                       
                   } else {
                       print("did not detect any face")
                   }
               }
           })
           let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
           try? imageRequestHandler.perform([faceDetectionRequest])
       }
    private func configureDevice() {
                if let device = getDevice() {
                    do {
                        try device.lockForConfiguration()
                        if device.isFocusModeSupported(.continuousAutoFocus) {
                            device.focusMode = .continuousAutoFocus
                        }
                        device.unlockForConfiguration()
                    } catch { print("failed to lock config") }
                    
                    do {
                        let input = try AVCaptureDeviceInput(device: device)
                        captureSession.addInput(input)
                    } catch { print("failed to create AVCaptureDeviceInput") }
                    DispatchQueue.main.async {
                        self.captureSession.startRunning()
                    }
                    
                    
                    let videoOutput = AVCaptureVideoDataOutput()
                    videoOutput.videoSettings = [String(kCVPixelBufferPixelFormatTypeKey): Int(kCVPixelFormatType_32BGRA)]
                    videoOutput.alwaysDiscardsLateVideoFrames = true
                    videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .utility))
                    
                    if captureSession.canAddOutput(videoOutput) {
                        captureSession.addOutput(videoOutput)
                    }
                }
            }
    private func getDevice() -> AVCaptureDevice? {
                let discoverSession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInTelephotoCamera, .builtInWideAngleCamera], mediaType: .video, position: .front)
                return discoverSession.devices.first
            }
}
