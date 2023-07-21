//
//  RFSDetectFacesResponse.h
//  FaceSDK
//
//  Created by Serge Rylko on 29.07.22.
//  Copyright © 2022 Regula. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const RFSDetectFacesErrorDomain NS_SWIFT_NAME(DetectFacesErrorDomain);

/// Error codes for the `RFSDetectFacesResponse` errors.
typedef NS_ERROR_ENUM(RFSDetectFacesErrorDomain, RFSDetectFacesErrorCode) {
  RFSDetectFacesErrorCodeAPIFailed,
} NS_SWIFT_NAME(DetectFacesError);

@class RFSDetectFaceResult;

NS_SWIFT_NAME(DetectFacesResponse)
@interface RFSDetectFacesResponse: NSObject

/// Single Face Detection result.
/// Preferred to use when Scenario supports only central face detection.
@property(nullable, nonatomic, readonly) RFSDetectFaceResult *detection;

/// All Face Detections Results.
/// Preferred to use when Scenario supports multiple faces detection.
@property(nullable, nonatomic, readonly, copy) NSArray<RFSDetectFaceResult *> *allDetections;

/// Current Image Quality Assessment Scenario
/// `nil` for Request with custom configuration.
@property(nullable, nonatomic, readonly, copy) NSString *scenario;

/// The error describes a failed detect faces request and contains `RFSDetectFacesErrorCode` codes.
/// This error belongs to the `RFSDetectFacesErrorDomain`.
@property(nullable, nonatomic, readonly, strong) NSError *error;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
