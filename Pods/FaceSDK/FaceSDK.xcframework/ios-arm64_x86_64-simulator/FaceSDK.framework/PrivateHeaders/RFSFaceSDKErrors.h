//
//  RFSFaceSDKErrors.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 5/3/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Key in userInfo for FaceSDK erros. Case label from ErrorCode enum. The value of this is a string.
FOUNDATION_EXPORT NSErrorUserInfoKey const RFSFaceSDKErrorCodeCaseKey NS_SWIFT_NAME(FaceSDKErrorCodeCaseKey);

/// Errors for APIService.
FOUNDATION_EXPORT NSErrorDomain const RFSAPIServiceErrorDomain NS_SWIFT_NAME(APIServiceErrorDomain);
typedef NS_ERROR_ENUM(RFSAPIServiceErrorDomain, RFSAPIServiceErrorCode) {
    /// Service responded with empty payload.
    RFSAPIServiceErrorEmptyResponse,
    /// Some error occured. Check the underlying error.
    RFSAPIServiceErrorUnderlying,
} NS_SWIFT_NAME(APIServiceError);

/// Errors for LivenessService.
FOUNDATION_EXPORT NSErrorDomain const RFSLivenessServiceErrorDomain NS_SWIFT_NAME(LivenessServiceErrorDomain);
typedef NS_ERROR_ENUM(RFSLivenessServiceErrorDomain, RFSLivenessServiceErrorCode) {
    /// Liveness process cancelled.
    RFSLivenessServiceErrorCancelled,
    /// Timeout between normal and scaled inputs.
    RFSLivenessServiceErrorTimeout,
    /// Attempt number exceeded given attemptsCount. Underlying error contains last `RFSLivenessServiceError` describing why attempt has failed.
    RFSLivenessServiceErrorAllAttemptsFailed,
    /// Service received the attempt but it failed to pass Liveness. There could be more information in underlying error.
    RFSLivenessServiceErrorAttemptFailed,
    /// Service received the attempt but it failed with undefined code and there is no liveness status.
    RFSLivenessServiceErrorUnknownAPIFailure,
    /// Networking service failed. Check the underlyingError.
    RFSLivenessServiceErrorNetworkingFailed,
    /// Application changed state to inactive causing the liveness process to fail current attempt.
    RFSLivenessServiceErrorAppInactive,
    /// Server response mapping failed
    RFSLivenessServiceErrorMappingFailed,
} NS_SWIFT_NAME(LivenessServiceError);

NS_ASSUME_NONNULL_END
