//
//  WelcomeVC.swift
//  Gym App
//
//  Created by Neha on 20/06/23.
//

import UIKit


class WelcomeVC: UIViewController {

    @IBOutlet weak var btnView: UIView!
    var aliaImgUrl = "https://images.indianexpress.com/2022/03/alia-bhatt-3.jpg?w=640"
    var SourceData:Data?
    let FaceRecogPoolId = "us-east-1:458394b1-1308-4ece-8523-e3502ca6b8b2"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnView.layer.cornerRadius = 30
     
    }
    @IBAction func nextBtn(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "ScanFaceVC") as! ScanFaceVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func login(_ sender:UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
   /* func connectFaceIot(){
        //  facedetect Configure
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: AWSRegion,
            identityPoolId: FaceRecogPoolId)
        let configuration = AWSServiceConfiguration(
            region: AWSRegion,
            credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
    
    
    
    
//    func getAWSImage(faceURL:String) {
//        //..........
//
//        DispatchQueue.main.async {
//            let url = URL(string: faceURL)
//            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//
//            self.SourceData = data
//        }
//
//
//    }
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Error handling...
          guard let imageData = data else { return }

          DispatchQueue.main.async {
            self.SourceData = imageData
          }
        }.resume()
      }
    }
    func getImageCompare(){
        
        var destinationData = Data()
        let  faceImg = UIImage(named: "Alia")!
        DispatchQueue.main.async {
            
//            if let theProfileImageUrl = URL(string: self.aliaImgUrl){
//                do {
//                    let imageData = try Data(contentsOf: theProfileImageUrl  )
//                    self.SourceData = imageData
//                } catch {
//                    print("Unable to load data: \(error)")
//                }
//            }
//            if let jpegData = image.jpegData(compressionQuality: 9.0) {
//                print("jpeg Data",jpegData.count) // 416318
//                SourceData = jpegData
//            }
            if let pngData = faceImg.pngData() {
                print("png Data",pngData.count)  // 1282319

                destinationData = pngData
            }
            
            
            self.getCompareImageS3Buckets(source1: self.SourceData ?? Data(), destination1: destinationData)
        }
       
    }
    let ASWIoTDataManager = "MyIotDataManager"
    var rekognitionObject : AWSRekognition?
    var matchedString: String?
    func getCompareImageS3Buckets(source1: Data, destination1: Data){
        print("\(source1),\(destination1)")
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
//                    for items in (response?.faceMatches) {
//                        self.matchedString = "\((items.similarity))"
//                    }
                    print("\(response?.faceMatches)")
                   print("Your face matched \(Float(self.matchedString!)!)%")
                }
                // self.view.makeToast("Your face matched \(Float(self.matchedString!)!)%", duration: 3, position: .center)
//                let alertVC = UIAlertController(title: "Attention", message: "I am an alert message you cannot dissmiss.", preferredStyle: .alert)
//
//               //Image by freepik.com, taken on flaticon.com
//
//                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//                     print("Ok button tapped")
//                      //self.captureSession.startRunning()
//                  })
//                alertVC.addAction(ok)
//                self.present(alertVC, animated: true, completion: nil)
                
            }
            else {
                print("error while face \(error?.localizedDescription)")
                DispatchQueue.main.async {
                    for items in (response?.faceMatches)! {
                        self.matchedString = "\((items.similarity))"
                    }
                   
                    let sNum = Double(self.matchedString ?? "")
                    if sNum! > 60.0 {
                        
                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
                            // let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeToMTRController") as! WelcomeToMTRController
                            // vc.matched = "Face has matched"
                            //  self.present(vc, animated: true, completion: nil)
                            let iotDataM = AWSIoTDataManager(forKey: self.ASWIoTDataManager)
                            if iotDataM.getConnectionStatus().rawValue == 2 {
                                iotDataM.disconnect()
                            }
                          print("Move to next screen ")
                        })
                    }
                    else {
                        let alertVC = UIAlertController(title: "Attention", message: "I am an alert message you cannot dissmiss.", preferredStyle: .alert)

                       //Image by freepik.com, taken on flaticon.com
                        
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                             print("Ok button tapped")
                              //self.captureSession.startRunning()
                          })
                        alertVC.addAction(ok)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
            }
        })
    }*/
}
