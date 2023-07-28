//
//  RegisterNewfaceViewController.swift
//  Andro Fit App
//
//  Created by SMIT iMac27 on 26/07/23.
//

import UIKit
import MLKit
import TensorFlowLite
import Alamofire
class RegisterNewfaceViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var faceanmeTF:UITextField!
    @IBOutlet weak var faceImage:UIImageView!
    var cropfaceImage = UIImage()
    var currentFaceVector: Array<Float32>? = nil
    var faceDetector:FaceDetector? = nil
    let maxRGBValue: Float32 = 255.0
    var interpreter: Interpreter? = nil
    var apiRegisterNewUserResponse:ApiRegisterNewUserResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.faceImage.image = cropfaceImage
        let faceDetectorOption: FaceDetectorOptions = {
            let option = FaceDetectorOptions()
            option.contourMode = .none
            option.performanceMode = .accurate
            return option
        }()
        faceDetector = FaceDetector.faceDetector(options: faceDetectorOption)
        initInterpreter()
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
    @IBAction func actionBackBtn(_ sender:UIButton){
        self.dismiss(animated: true)
        NotificationCenter.default.post(name: Notification.Name("updatePhotoProcessing"), object: nil)
    }

    @IBAction func actionAddFace(_ sender:UIButton){
        if self.faceImage.image  == nil {
            self.view.makeToast("Please uplaod  image", duration: 2.0,position: .center)
            return
        }else if self.faceanmeTF.text == "" {
            self.view.makeToast("Please enter name ", duration: 2.0,position: .center)
            return
        }else {
            self.processImage(uiImage: self.faceImage.image!)
        }
       
    }
    func processImage(uiImage: UIImage) {
        
        self.faceDetector?.process(getVisionImage(from: uiImage)) { faces, error in
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
            
            if let faceMatcher = FaceMatcher(modelPath: localModelFilePath ?? "") {
                if let image = uiImage.cgImage {
                    if let faceVector = faceMatcher.createFaceVector(ofImage: image) {
                        print("faceVector \(faceVector)")
                        self.currentFaceVector = faceVector
                        self.registerFace(self.faceanmeTF.text ?? "")
                        print("faceVector to upload : \(faceVector)")
                    } else {
                        print("faceVector not created ")
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
        
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
            var frames = [FrameWithLabel]()
            for (index, face) in faces.enumerated() {
                var label = "\(index + 1)"
                if let faceCrop = uiImage.cgImage?.cropping(to: face.frame) {
                    if let image = ImageUtils.resizeWithCoreGraphics(cgImage: faceCrop, newSize: CGSize(width: 112, height: 112)) {
                        let image = faceCrop
                        DispatchQueue.main.async {
                            self.faceImage.image = UIImage(cgImage: image)
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
                            try self.interpreter?.copy(inputData, toInputAt: 0)
                            try self.interpreter?.invoke()
                            
                            if let output = try self.interpreter?.output(at: 0) {
                                let faceVector = UnsafeMutableBufferPointer<Float32>.allocate(capacity: 192)
                                output.data.copyBytes(to: faceVector)
                                print("Face vector: \(faceVector.debugDescription)")
                                //self.currentFaceVector = faceVector
                                DispatchQueue.main.async {
                                    self.registerFace(self.faceanmeTF.text ?? "")
                                }
                                
                            }
                            try self.interpreter?.allocateTensors()
                        } catch {
                            print("error in recognition \(error.localizedDescription)")
                        }
                        
                    }
                    frames.append(FrameWithLabel(frame: face.frame, label: label))
                }
            }
        }
    }
 

    func registerFace(_ name: String) {
        if let vector = currentFaceVector {
            print("Face registered with : \(vector) , \(currentFaceVector)")
            let floatBuffer: Array<Float32>? = vector
            let resultString = convertFloatToString(ofArray: floatBuffer ?? [Float]())
            print("Face vector in string",resultString)
            //self.hitApiRegisterFace(faceVector: resultString)
            self.hitAPiUploadImage(faceVector: resultString)

        }
    }
    func convertFloatToString(ofArray:[Float]) -> String{

        // Convert array of floats to array of strings
        let stringArray = ofArray.map { String($0) }
        // Join the strings with a separator (e.g., comma)
        let resultString = stringArray.joined(separator: " ")
        print(resultString)
        return resultString
    }
    func hitAPiUploadImage(faceVector:String){
        
        let UrlString = "http://3.232.30.130:3006/registeruser"
        
        let parameters = [ "UserName": self.faceanmeTF.text ?? "","faceVector": faceVector]
        print("update Image URl \(UrlString), \(parameters) ")
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in parameters {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            //guard let imgData = profileImage.jpegData(compressionQuality: 1) else { return }
            //multipartFormData.append(imgData, withName: "file", fileName: "" + ".jpeg", mimeType: "image/jpeg")
            
            
            if let imageData = self.faceImage.image!.jpegData(compressionQuality: 0.1) {
                        multipartFormData.append(imageData, withName: "image", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            
            
        },to: UrlString , usingThreshold: UInt64.init(),
          method: .post,
          headers: nil).response{ response in
          
            switch (response.result){
            case .success(_):
                guard let data = response.data else {return}
                let decoder = JSONDecoder()
                do{
                    self.apiRegisterNewUserResponse = try? decoder.decode(ApiRegisterNewUserResponse.self, from: data)
                                  
                    print("hitApiUpdateInfo,\(self.apiRegisterNewUserResponse)")
                    if self.apiRegisterNewUserResponse?.status == true {
                        self.dismiss(animated: true)
                        NotificationCenter.default.post(name: Notification.Name("updatePhotoProcessing"), object: nil)
                    }

                }catch{
                    print("error message")
                }
            case .failure(let error):
                print("hitApiUpdateInfo",error.localizedDescription)
            }
            
        }
    }
    
    func hitApiRegisterFace(faceVector:String){
          let url = "http://3.232.30.130:3006/registeruser"
          
        let parameters = [ "UserName": self.faceanmeTF.text ?? "","faceVector": faceVector]
          print("hitApiSendOTP parameters \(parameters) and url \(url)")
          
          AF.request( URL(string: url)!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
              .validate()
              .responseData(completionHandler: {(response) in
             
                  switch(response.result){
                      case .success(_):
                          print("hitApiSendOTP \(response)")
                          do {
                              guard let data = response.data else {return}
                              let decoder = JSONDecoder()
                              self.apiRegisterNewUserResponse = try? decoder.decode(ApiRegisterNewUserResponse.self, from: data)
                              
                              print("hitApiSendOTP,\(self.apiRegisterNewUserResponse)")
                             
                              if self.apiRegisterNewUserResponse?.status == true {
                                  self.dismiss(animated: true)
                                  NotificationCenter.default.post(name: Notification.Name("updatePhotoProcessing"), object: nil)
                              }
                          }catch {
                              
                          }
                          //then you can access your result
                      case .failure(let error):
                          print("hitApiSendOTP is \(error.localizedDescription)")
                      }
                  })
          }

}
