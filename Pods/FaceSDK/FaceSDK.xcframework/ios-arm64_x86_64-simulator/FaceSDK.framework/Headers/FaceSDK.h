//
//  FaceSDK.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 5/19/19.
//  Copyright © 2019 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

// :MARK: Common
#import <FaceSDK/RFSFaceSDK.h>
#import <FaceSDK/RFSURLRequestInterceptingDelegate.h>
#import <FaceSDK/RFSImage.h>
#import <FaceSDK/RFSImageType.h>
#import <FaceSDK/RFSPoint.h>
#import <FaceSDK/RFSOverriding.h>
#import <FaceSDK/RFSDeprecated.h>

// :MARK: Liveness
#import <FaceSDK/RFSLivenessConfiguration.h>
#import <FaceSDK/RFSLivenessResponse.h>

// :MARK: FaceCapture
#import <FaceSDK/RFSFaceCaptureConfiguration.h>
#import <FaceSDK/RFSFaceCaptureResponse.h>

// :MARK: MatchFaces
#import <FaceSDK/RFSMatchFacesRequest.h>
#import <FaceSDK/RFSMatchFacesResponse.h>
#import <FaceSDK/RFSMatchFacesImage.h>
#import <FaceSDK/RFSMatchFacesDetection.h>
#import <FaceSDK/RFSMatchFacesDetectionFace.h>
#import <FaceSDK/RFSMatchFacesComparedFace.h>
#import <FaceSDK/RFSMatchFacesComparedFacesPair.h>
#import <FaceSDK/RFSMatchFacesSimilarityThresholdSplit.h>

// :MARK: DetectFaces
#import <FaceSDK/RFSDetectFacesRequest.h>
#import <FaceSDK/RFSDetectFacesResponse.h>
#import <FaceSDK/RFSImageQualityResult.h>
#import <FaceSDK/RFSImageQualityGroup.h>
#import <FaceSDK/RFSImageQualityRange.h>
#import <FaceSDK/RFSDetectFaceResult.h>
#import <FaceSDK/RFSImageQualityCharacteristic.h>
#import <FaceSDK/RFSImageQualityColorCharacteristic.h>
#import <FaceSDK/RFSImageQualityCharacteristicName.h>
#import <FaceSDK/RFSDetectFacesAttribute.h>
#import <FaceSDK/RFSDetectFacesAttributeResult.h>
#import <FaceSDK/RFSDetectFacesConfiguration.h>
#import <FaceSDK/RFSOutputImageParams.h>
#import <FaceSDK/RFSOutputImageCrop.h>

// :MARK: UI
#import <FaceSDK/RFSPassthroughView.h>
#import <FaceSDK/RFSLivenessContentView.h>
#import <FaceSDK/RFSLivenessProcessingContentView.h>
#import <FaceSDK/RFSFaceCaptureContentView.h>
#import <FaceSDK/RFSCameraToolbarView.h>
#import <FaceSDK/RFSHintView.h>
#import <FaceSDK/RFSCameraOverlayView.h>
#import <FaceSDK/RFSCustomization.h>
#import <FaceSDK/RFSUIConfiguration.h>

// :MARK: Database
#import <FaceSDK/RFSPersonDatabase.h>
#import <FaceSDK/RFSPerson.h>
#import <FaceSDK/RFSPersonImage.h>
#import <FaceSDK/RFSPersonGroup.h>
#import <FaceSDK/RFSDBBaseItem.h>
#import <FaceSDK/RFSImageUpload.h>
#import <FaceSDK/RFSSearchPersonRequest.h>
#import <FaceSDK/RFSEditGroupPersonsRequest.h>
#import <FaceSDK/RFSSearchPerson.h>
#import <FaceSDK/RFSSearchPersonImage.h>
#import <FaceSDK/RFSSearchPersonDetection.h>
