//
//  RFSMatchFacesDetection.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 23/11/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSMatchFacesDetectionFace;
@class RFSMatchFacesImage;

/// `RFSMatchFacesDetection` represents detection results on an input image as a part of `RFSMatchFacesResponse`.
NS_SWIFT_NAME(MatchFacesDetection)
@interface RFSMatchFacesDetection : NSObject

/// The index to the input image in the input array provided to the request.
@property(nonatomic, readonly, strong, nonnull) NSNumber *imageIndex;

/// The input image used for comparison operation.
@property(nonatomic, readonly, strong, nonnull) RFSMatchFacesImage *image;

/// The array of faces detected on the image.
@property(nonatomic, readonly, strong, nonnull) NSArray<RFSMatchFacesDetectionFace *> *faces;

/// The error describes a failed face detection and contains `RFSMatchFacesErrorCode` codes.
/// This error belongs to the `RFSMatchFacesErrorDomain`.
@property(nonatomic, readonly, strong, nullable) NSError *error;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
