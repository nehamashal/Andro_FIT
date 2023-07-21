//
//  RFSBackendError.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 11/18/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

/// Key in userInfo for `RFSBackendErrorDomain`. Original message value of `RFSBackendErrorUndefined`. The value of this is a string.
FOUNDATION_EXPORT NSErrorUserInfoKey const RFSBackendErrorOriginalMessageKey NS_SWIFT_NAME(BackendError.OriginalMessageKey);

/// Key in userInfo for `RFSBackendErrorDomain`. Original code value of `RFSBackendErrorUndefined`. The value of this is a number.
FOUNDATION_EXPORT NSErrorUserInfoKey const RFSBackendErrorOriginalCodeKey NS_SWIFT_NAME(BackendError.OriginalCodeKey);

/// Backend errors. Error codes match service error codes.
FOUNDATION_EXPORT NSErrorDomain const RFSBackendErrorDomain NS_SWIFT_NAME(BackendErrorDomain);
typedef NS_ERROR_ENUM(RFSBackendErrorDomain, RFSBackendErrorCode) {
    // NOTE: MatchFaces related errors (aka `eFaceRecognizerErrorCode`).
    RFSBackendErrorImageEmpty = 1,
    RFSBackendErrorFaceNotDetected = 2,
    RFSBackendErrorLandmarksNotDetected = 3,
    RFSBackendErrorFaceAlignerFailed = 4,
    RFSBackendErrorDescriptorExtractorError = 5,

    // NOTE: General FaceService errors (aka `eFaceRProcessorErrorCodes`).
    /// Service is missing a valid license file.
    RFSBackendErrorNoLicense = 200,
    RFSBackendErrorParamsReadError = 203,
    RFSBackendErrorClosedEyesDetected = 230,
    RFSBackendErrorLowQuality = 231,
    RFSBackendErrorHighAsymmetry = 232,
    RFSBackendErrorFaceOverEmotional = 233,
    RFSBackendErrorSunglassesDetected = 234,
    RFSBackendErrorSmallAge = 235,
    RFSBackendErrorHeaddressDetected = 236,
    RFSBackendErrorFacesNotMatched = 237,
    RFSBackendErrorImagesCountLimitExceeded = 238,
    RFSBackendErrorMedicineMaskDetected = 239,
    RFSBackendErrorOcclusionDetected = 240,
    RFSBackendErrorForeheadGlassesDetected = 242,
    RFSBackendErrorMouthOpened = 243,
    RFSBackendErrorArtMaskDetected = 244,
    RFSBackendErrorElectronicDeviceDetected = 245,
    RFSBackendErrorTrackBreak = 246,
    RFSBackendErrorWrongGeo = 247,
    RFSBackendErrorWrongOf = 248,
    RFSBackendErrorWrongView = 249,

    /// Undefined backend error.
    /// This error code means that the response from the service had an error code which is not declared in this enum.
    RFSBackendErrorUndefined = -1,
} NS_SWIFT_NAME(BackendErrorCode);

FOUNDATION_EXPORT BOOL RFSBackendErrorHasErrorCode(NSInteger code) CF_SWIFT_NAME(BackendError.hasErrorCode(_:));

NS_SWIFT_NAME(BackendError)
@interface RFSBackendError : NSError

@property(nonatomic, readonly, assign) RFSBackendErrorCode backendErrorCode;

- (instancetype)initWithDomain:(NSErrorDomain)domain
                          code:(NSInteger)code
                      userInfo:(nullable NSDictionary<NSErrorUserInfoKey, id> *)dict RFS_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE;

- (instancetype)initWithBackendErrorCode:(RFSBackendErrorCode)code
                                userInfo:(nullable NSDictionary<NSErrorUserInfoKey, id> *)userInfo NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithBackendErrorCode:(RFSBackendErrorCode)code;

+ (nullable instancetype)decodeFromJSON:(nonnull NSDictionary<NSString *, id> *)json;

@end

NS_ASSUME_NONNULL_END
