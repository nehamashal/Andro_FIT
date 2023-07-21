//
//  FaceRecoViewController.swift
//  Andro Fit App
//
//  Created by Neha on 17/07/23.
//

import UIKit


var compareData: Data?
var destData: Data?
/*
class FaceRecoViewController: UIViewController {
    let ASWIoTDataManager = "MyIotDataManager"
    var rekognitionObject : AWSRekognition?
    var matchedString: String?
    //AVCapture Configure
    var captureSession: AVCaptureSession!
    var imgOutPut: AVCapturePhotoOutput!
    var vdoPreviewLayer: AVCaptureVideoPreviewLayer!
    
//    var plateNumberDetails : ApiLoginResponseModel?
    var driverFaceUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
//                SwiftLoader.show(title: "Initialize your face..", animated: true)
                getCompareImageS3Buckets(source1: imageData, destination1: compareData!)
            }
            else {
//                SwiftLoader.hide()
                // SwiftLoader.show(title: "Initialize your face..", animated: true)
            }
        }
        // captureImageView.image = image
    }
    func getAWSImage(faceURL:String) {
        //..........
        let url = URL(string: faceURL)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        destData = data
        compareData = data
        
    }
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
                // self.view.makeToast("Your face matched \(Float(self.matchedString!)!)%", duration: 3, position: .center)
//                let alertVC =  UIAlertController(title: "Andro Fit", description: NSLocalizedString("faceMatchedText", comment: ""), image:#imageLiteral(resourceName: "appLogo"), style: .alert) //Image by freepik.com, taken on flaticon.com
//                alertVC.addAction(UIAlertAction(title: "OK", style: .default, action: { () -> Void in
//                    self.captureSession.startRunning()
//                }))
//                self.present(alertVC, animated: true, completion: nil)
                self.view.makeToast("Your face matched \(Float(self.matchedString!)!)%", duration: 3, position: .center)
            }
            else {
                DispatchQueue.main.async {
                    for items in (response?.faceMatches)! {
                        self.matchedString = "\((items.similarity))"
                    }
                    let sNum = Double(self.matchedString ?? "")
                    if sNum! > 60.0 {
//                        self.btnCamera.isUserInteractionEnabled = false
//                        self.btnCamera.setImage(UIImage(imageLiteralResourceName: "matched"), for: .normal)
//                        self.lblStatus.text = "Face has matched"
                        self.view.makeToast("Face has matched \(Float(self.matchedString!)!)%", duration: 3, position: .center)
                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
                            // let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeToMTRController") as! WelcomeToMTRController
                            // vc.matched = "Face has matched"
                            //  self.present(vc, animated: true, completion: nil)
                            let iotDataM = AWSIoTDataManager(forKey: self.ASWIoTDataManager)
                            if iotDataM.getConnectionStatus().rawValue == 2 {
                                iotDataM.disconnect()
                            }
//                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlateNumberViewController") as! PlateNumberViewController
//                            vc.plateNumberDetail = self.plateNumberDetails
//                            self.navigationController?.pushViewController(vc, animated: false)
                        })
                    }
                    else {
//                        let alertVC = UIAlertController(title: "My Taxi Ride", description: NSLocalizedString("faceMatchedText", comment: ""), image:#imageLiteral(resourceName: "appLogo"), style: .alert) //Image by freepik.com, taken on flaticon.com
//                        alertVC.addAction(UIAlertAction(title: "OK", style: .default, action: { () -> Void in
//                            self.captureSession.startRunning()
//                        }))
//                        self.present(alertVC, animated: true, completion: nil)
                        self.view.makeToast("faceMatchedText \(Float(self.matchedString!)!)%", duration: 3, position: .center)
                    }
                }
            }
        })
    }

}
*/
