//
//  RFSDetectFacesConfiguration.h
//  FaceSDK
//
//  Created by Serge Rylko on 15.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSDetectFacesAttribute.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSOutputImageParams;
@class RFSImageQualityCharacteristic;

/// Custom configuration for `RFSDetectFacesRequest`.
NS_SWIFT_NAME(DetectFacesConfiguration)
@interface RFSDetectFacesConfiguration: NSObject

/// Current array for the face image detection attributes.
@property(nullable, nonatomic, strong) NSArray<RFSDetectFacesAttribute> *attributes;

/// Current array for the face image quality assessment rules.
@property(nullable, nonatomic, strong) NSArray<RFSImageQualityCharacteristic *> *customQuality;

/// If set. the uploaded image is processed according to the indicated settings
@property(nullable, nonatomic, strong) RFSOutputImageParams *outputImageParams;

/// Whether to process only the central face on the image or all the faces.
/// If set to YES, the SDK detects and processes only one—the most central face in the image.
/// If set to NO, the SDK processess all faces in the image.
/// Default is NO.
@property(nonatomic, assign) BOOL onlyCentralFace;

@end

NS_ASSUME_NONNULL_END
