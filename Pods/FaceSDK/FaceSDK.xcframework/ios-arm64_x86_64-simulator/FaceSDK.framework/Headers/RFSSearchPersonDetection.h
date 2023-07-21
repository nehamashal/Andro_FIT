//
//  RFSSearchPersonDetection.h
//  FaceSDK
//
//  Created by Serge Rylko on 19.06.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import "Foundation/Foundation.h"
#import <FaceSDK/RFSMacros.h>
#import <UIKit/UIGeometry.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSPoint;
@class UIImage;

NS_SWIFT_NAME(PersonDatabase.SearchPersonDetection)
@interface RFSSearchPersonDetection : NSObject

/// Absolute coordinates of five points of each detected face: left eye, right eye, nose, left point of lips, right point of lips.
@property (nonatomic, strong, readonly) NSArray<RFSPoint *> *landmarks;

/// Rectangular area of the detected face in the original image.
@property (nonatomic, assign, readonly) CGRect rect;

/// Base64 image of the aligned and cropped portrait.
/// Returned if `RFSDetectFacesConfiguration.outputImageParams` is set or predefined scenario is used.
@property (nullable, nonatomic, strong, readonly) UIImage *crop;

/// Rotation is measured counterclockwise in degrees, with zero indicating that a line drawn between the eyes is horizontal relative to the image orientation.
@property (nonatomic, strong, readonly) NSNumber *rotationAngle;

@end

NS_ASSUME_NONNULL_END
