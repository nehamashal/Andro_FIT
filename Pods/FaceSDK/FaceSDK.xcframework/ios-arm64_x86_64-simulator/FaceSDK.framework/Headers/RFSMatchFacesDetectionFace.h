//
//  RFSMatchFacesDetectionFace.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 23/11/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSPoint;
@class UIImage;

/// `RFSMatchFacesDetectionFace` represents face detection information as a part of `RFSMatchFacesResponse`.
NS_SWIFT_NAME(MatchFacesDetectionFace)
@interface RFSMatchFacesDetectionFace : NSObject

/// The index of the face detection object in the array of detections.
@property(nonatomic, readonly, strong, nonnull) NSNumber *faceIndex;

/// Main coordinates of the detected face (eyes, nose, lips, ears and etc.).
@property(nonatomic, readonly, strong, nonnull) NSArray<RFSPoint *> *landmarks;

/// Rectangular area of the detected face in the original image.
@property(nonatomic, readonly, assign) CGRect faceRect;

/// Rotation is measured counterclockwise in degrees, with zero indicating that a line drawn between the eyes is horizontal relative to the image orientation.
@property(nonatomic, readonly, strong, nullable) NSNumber *rotationAngle;

/// Cropped face image from original input image. Defaults to `nil`.
/// Enable request's `RFSMatchFacesRequest.thumbnails` boolean property to let the service create thumbnail images.
/// @see `RFSMatchFacesRequest`.
@property(nonatomic, readonly, strong, nullable) UIImage *thumbnailImage;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
