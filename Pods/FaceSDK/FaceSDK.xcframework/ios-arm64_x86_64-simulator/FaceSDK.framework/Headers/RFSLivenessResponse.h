//
//  RFSLivenessResponse.h
//  FaceSDK
//
//  Created by Dmitry Smolyakov on 10/21/20.
//  Copyright © 2020 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

/// `RFSLivenessErrorDomain` indicates an error related to the Liveness. For error codes see `RFSLivenessError`.
FOUNDATION_EXPORT NSErrorDomain const RFSLivenessErrorDomain NS_SWIFT_NAME(LivenessErrorDomain);

/// Error codes for the `RFSLivenessResponse` errors.
typedef NS_ERROR_ENUM(RFSLivenessErrorDomain, RFSLivenessErrorCode) {
    /// User cancelled liveness processing.
    RFSLivenessErrorCancelled,
    /// Processing finished by timeout.
    RFSLivenessErrorProcessingTimeout,
    /// Processing failed. Liveness service received the attempt but it failed to pass validation.
    RFSLivenessErrorProcessingFailed,
    /// Liveness API call failed due to networking error or backend internal error.
    RFSLivenessErrorAPICallFailed,
    /// There is no valid license on the service.
    RFSLivenessErrorNoLicense,
    /// Liveness not initialized.
    RFSLivenessErrorInitializationFailed,
    /// Client application did enter the background, liveness process interrupted.
    RFSLivenessErrorApplicationInactive
} NS_SWIFT_NAME(LivenessError);

/// The status of the Liveness processing.
typedef NS_ENUM(NSUInteger, RFSLivenessStatus) {
    /// The liveness check is passed successfully.
    RFSLivenessStatusPassed,
    /// The liveness check result is unknown.
    RFSLivenessStatusUnknown
} NS_SWIFT_NAME(LivenessStatus);

/// The response from the Liveness module.
NS_SWIFT_NAME(LivenessResponse)
@interface RFSLivenessResponse : NSObject

@property(readonly, nonatomic, copy, nullable) NSString *tag;
@property(readonly, nonatomic, copy, nullable) NSString *transactionId;
@property(readonly, nonatomic, copy, nullable) NSNumber *estimatedAge;

/// The input image used to determine the liveness.
@property(readonly, nonatomic, strong, nullable) UIImage *image;

/// The status of the Liveness processing.
@property(readonly, nonatomic, assign) RFSLivenessStatus liveness;

/// The error describes a failed liveness check and contains `RFSLivenessError` codes.
/// This error belongs to the `RFSLivenessErrorDomain`.
@property(readonly, nonatomic, strong, nullable) NSError *error;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
