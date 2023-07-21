//
//  RFSMatchFacesResponse.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 5/19/19.
//  Copyright © 2019 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSMatchFacesComparedFacesPair;
@class RFSMatchFacesDetection;

/// `RFSMatchFacesErrorDomain` indicates an error related to the `RFSMatchFacesRequest`. For error codes see `RFSMatchFacesError`.
FOUNDATION_EXPORT NSErrorDomain const RFSMatchFacesErrorDomain NS_SWIFT_NAME(MatchFacesErrorDomain);

/// Error codes for the `RFSMatchFacesResponse` errors.
typedef NS_ERROR_ENUM(RFSMatchFacesErrorDomain, RFSMatchFacesErrorCode) {
    RFSMatchFacesErrorImageEmpty,
    RFSMatchFacesErrorFaceNotDetected,
    RFSMatchFacesErrorLandmarksNotDetected,
    RFSMatchFacesErrorFaceAlignerFailed,
    RFSMatchFacesErrorDescriptorExtractorError,
    RFSMatchFacesErrorImagesCountLimitExceeded,

    /// MatchFaces API call failed due to networking error or backend internal error.
    RFSMatchFacesErrorAPICallFailed,
    /// MatchFaces service received the attempt but it failed to pass validation.
    RFSMatchFacesErrorProcessingFailed,
    /// There is no valid license on the service.
    RFSMatchFacesErrorNoLicense,
} NS_SWIFT_NAME(MatchFacesError);

/// The response from the `RFSMatchFacesRequest`.
NS_SWIFT_NAME(MatchFacesResponse)
@interface RFSMatchFacesResponse : NSObject

@property(readonly, nonatomic, copy, nullable) NSString *tag;

/// The error describes a failed match faces request and contains `RFSMatchFacesErrorCode` codes.
/// This error belongs to the `RFSMatchFacesErrorDomain`.
@property(readonly, nonatomic, strong, nullable) NSError *error;

/// Face comparison results with score and similarity values.
@property(readonly, nonatomic, strong, nonnull) NSArray<RFSMatchFacesComparedFacesPair *> *results;

/// Face detection results for each given image.
@property(readonly, nonatomic, strong, nonnull) NSArray<RFSMatchFacesDetection *> *detections;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
