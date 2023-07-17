//
//  FaceDetectionVC.swift
//  Andro Fit
//
//  Created by Neha on 17/07/23.
//

   /* import UIKit
    import AWSCore
    import AWSRekognition
    import AWSIoT
    import AVFoundation
    var compareData: Data?
    class FaceDetectionVC: UIViewController,AVCapturePhotoCaptureDelegate {
        var rekognitionObject : AWSRekognition?
        var infoLinksMap: [Int:String] = [1000:""]
        @IBOutlet weak var driverImage: UIImageView!
        
        @IBOutlet weak var preview: UIView!
        @IBOutlet weak var detectDriverImg: UIImageView!
        var fDetetct: Bool?
        @IBOutlet weak var btnCamera: UIButton!
        
        @IBOutlet weak var lblStatus: UILabel!
        
        var matchedString: String?
        //AVCapture Configure
        var captureSession: AVCaptureSession!
        var imgOutPut: AVCapturePhotoOutput!
        var vdoPreviewLayer: AVCaptureVideoPreviewLayer!
        
        var plateNumberDetails : ApiLoginResponseModel?
        var driverFaceUrl : String?
        
        override func viewDidLoad() {
            super.viewDidLoad()
             setStatusBarBackgroundColor(.lightGray)
            self.btnCamera.isUserInteractionEnabled = true
            connectFaceIot()
            rekognitionObject = AWSRekognition.default()
            
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.btnCamera.setImage(UIImage(imageLiteralResourceName: "open_camera_80x80"), for: .normal)
            lblStatus.text = NSLocalizedString("cameraPosText", comment: "")
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
        
        func setupLivePreview(){
            vdoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            vdoPreviewLayer.videoGravity = .resizeAspectFill
            vdoPreviewLayer.connection?.videoOrientation = .portrait
            preview.layer.addSublayer(vdoPreviewLayer)
            DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
                self.captureSession.startRunning()
                //Step 13
                DispatchQueue.main.async {
                    self.vdoPreviewLayer.frame = self.preview.bounds
                    self.preview.layer.insertSublayer(self.vdoPreviewLayer!, at: 0)
                }
            }
        }
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            guard let imageData = photo.fileDataRepresentation()
                else { return }
            
            let image = UIImage(data: imageData)
            //driverImage.image = image
            self.captureSession.stopRunning()
            getAWSImage(faceURL: driverFaceUrl!)
            defer{
                if compareData != nil {
                    SwiftLoader.show(title: "Initialize your face..", animated: true)
                    getCompareImageS3Buckets(source1: imageData, destination1: compareData!)
                }
                else {
                    SwiftLoader.hide()
                    // SwiftLoader.show(title: "Initialize your face..", animated: true)
                }
            }
            // captureImageView.image = image
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.captureSession.stopRunning()
        }
        
        func getAWSImage(faceURL:String) {
            //..........
            let url = URL(string: faceURL)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
         
            compareData = data
            
        }
        
        // Compare S3 Bucket Image
        func getCompareImageS3Buckets(source1: Data, destination1: Data){
            
            let sourceImage = AWSRekognitionImage()
            // let sourceImageS3Object = AWSRekognitionS3Object()
            // sourceImageS3Object?.bucket = "face-badges"
            //  sourceImageS3Object?.name = "me.jpg"
            // sourceImage?.s3Object = sourceImageS3Object
            sourceImage?.bytes = source1
            
            let targetImage = AWSRekognitionImage()
            // let targetImageS3Object = AWSRekognitionS3Object()
            // targetImageS3Object?.bucket = "face-badges"
            //  targetImageS3Object?.name = "me2.jpg"
            // targetImage?.s3Object = targetImageS3Object
            targetImage?.bytes = destination1
            //   AWSRekognitionCompareFacesMatch
            let request = AWSRekognitionCompareFacesRequest()
            request?.similarityThreshold = 90
            request?.sourceImage = sourceImage
            request?.targetImage = targetImage
            matchedString = "0.00"
            rekognitionObject?.compareFaces(request!, completionHandler: { (response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    // self.view.makeToast("Your face matched \(Float(self.matchedString!)!)%", duration: 3, position: .center)
                    let alertVC = PMAlertController(title: "My Taxi Ride", description: NSLocalizedString("faceMatchedText", comment: ""), image:#imageLiteral(resourceName: "appLogo"), style: .alert) //Image by freepik.com, taken on flaticon.com
                    alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () -> Void in
                        self.captureSession.startRunning()
                    }))
                    self.present(alertVC, animated: true, completion: nil)
                    
                }
                else {
                    DispatchQueue.main.async {
                        for items in (response?.faceMatches)! {
                            self.matchedString = "\((items.similarity))"
                        }
                        SwiftLoader.hide()
                        let sNum = Double(self.matchedString ?? "")
                        if sNum! > 60.0 {
                            self.btnCamera.isUserInteractionEnabled = false
                            self.btnCamera.setImage(UIImage(imageLiteralResourceName: "matched"), for: .normal)
                            self.lblStatus.text = "Face has matched"
                            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
                                // let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeToMTRController") as! WelcomeToMTRController
                                // vc.matched = "Face has matched"
                                //  self.present(vc, animated: true, completion: nil)
                                let iotDataM = AWSIoTDataManager(forKey: ASWIoTDataManager)
                                if iotDataM.getConnectionStatus().rawValue == 2 {
                                    iotDataM.disconnect()
                                }
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlateNumberViewController") as! PlateNumberViewController
                                vc.plateNumberDetail = self.plateNumberDetails
                                self.navigationController?.pushViewController(vc, animated: false)
                            })
                        }
                        else {
                            let alertVC = PMAlertController(title: "My Taxi Ride", description: NSLocalizedString("faceMatchedText", comment: ""), image:#imageLiteral(resourceName: "appLogo"), style: .alert) //Image by freepik.com, taken on flaticon.com
                            alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () -> Void in
                                self.captureSession.startRunning()
                            }))
                            self.present(alertVC, animated: true, completion: nil)
                        }
                    }
                }
            })
        }
        
        //END.....
        
        @IBAction func btnCameraTapped(_ sender: Any) {
            SwiftLoader.show(title: "Initialize your face..", animated: true)
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            imgOutPut.capturePhoto(with: settings, delegate: self)
            
        }
      }
*/
