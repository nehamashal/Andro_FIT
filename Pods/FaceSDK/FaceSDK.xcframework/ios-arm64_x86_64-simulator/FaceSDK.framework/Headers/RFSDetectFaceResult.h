//
//  RFSDetectFaceResult.h
//  FaceSDK
//
//  Created by Serge Rylko on 3.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSImageQualityResult;
@class UIImage;
@class RFSPoint;
@class RFSDetectFacesAttributeResult;

NS_SWIFT_NAME(DetectFaceResult)
@interface RFSDetectFaceResult: NSObject

/// The array for the face image quality assessments
@property(nullable, nonatomic, readonly, copy) NSArray<RFSImageQualityResult *> *quality;

/// The array of the checked attributes.
@property(nullable, nonatomic, readonly, copy) NSArray<RFSDetectFacesAttributeResult *> *attributes;

/// Base64 image of the aligned and cropped portrait.
/// Returned if `RFSDetectFacesConfiguration.outputImageParams` is set or predefined scenario is used.
@property(nullable, nonatomic, readonly) UIImage *crop;

/// Сoordinates of the rectangular area that contains the face relative to the overall image.
@property(nonatomic, readonly, assign) CGRect faceRect;

/// Coordinates of the rectangle with the face on the original image prepared for the face crop.
/// Requires `RFSOutputImageCrop.returnOriginalRect` is set.
/// Returns 'CGRectZero' if `RFSOutputImageCrop.returnOriginalRect` isn't set.
@property(nonatomic, readonly, assign) CGRect originalRect;

/// Absolute coordinates of five points of each detected face: left eye, right eye, nose, left point of lips, right point of lips.
@property(nullable, nonatomic, readonly, copy) NSArray<RFSPoint *> *landmarks;

/// Summary of all image quality assessments.
/// Returns YES if all image quality assessments have success status.
/// Returns NO if any of image quality assessments have non-success status or none of quality assessments were requested.
@property(nonatomic, readonly, assign) BOOL isQualityCompliant;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
