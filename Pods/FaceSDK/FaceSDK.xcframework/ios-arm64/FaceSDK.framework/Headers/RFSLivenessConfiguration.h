//
//  RFSLivenessConfiguration.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 4/15/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FaceSDK/RFSBaseConfiguration.h>
#import <FaceSDK/RFSCameraPosition.h>

NS_SWIFT_NAME(LivenessStepSkip)
typedef NS_OPTIONS(NSUInteger, RFSLivenessStepSkip) {
    RFSLivenessStepSkipNone         = 0,        // default
    RFSLivenessStepSkipOnboarding   = 1 << 0,   // don't show liveness onboarding screen
    RFSLivenessStepSkipSuccess      = 1 << 1    // don't show liveness success screen
};

NS_ASSUME_NONNULL_BEGIN

/// Mutable builder part of the `RFSLivenessConfiguration`.
NS_SWIFT_NAME(LivenessConfigurationBuilder)
@interface RFSLivenessConfigurationBuilder: RFSBaseConfigurationBuilder
@end

/// Configuration for the Liveness processing.
///
/// This class is used as a parameters for `-[RFSFaceSDK startLivenessFrom:animated:configuration:onLiveness:completion:]`.
/// The configuration provides convenient properties to change the behavior and the appearance of the Liveness UI module.
NS_SWIFT_NAME(LivenessConfiguration)
@interface RFSLivenessConfiguration : RFSBaseConfiguration<RFSLivenessConfigurationBuilder *> <NSObject>

#pragma mark - Liveness

/// Defines, whether the logo is visible on the bottom of Liveness UI screens. Defaults to `true`.
@property(readonly, nonatomic, assign, getter=isCopyright) BOOL copyright;

/// Defines which steps of the user interface can be omitted. See RFSLivenessStepSkip enum for details.
@property(readonly, nonatomic, assign) RFSLivenessStepSkip stepSkippingMask;

/// The number of attempts to pass the Liveness before completing with error. Defaults to `0`.
/// When set to `0`  the Liveness will always ask to retry on error.
/// When set to `1` or more the Liveness will end with `RFSLivenessError.RFSLivenessErrorProcessingAttemptsEnded` error when the number of attemps exceeds.
@property(readonly, nonatomic, assign) NSInteger attemptsCount;

/// Defines whether the liveness request sends a location of a device. Defaults to `true`.
/// When set to `true` the liveness request to web service will contain the `location` object within the json `metadata` object.
/// The location is used only when permissions are granted and the location is available.
@property(readonly, nonatomic, assign, getter=isLocationTrackingEnabled) BOOL locationTrackingEnabled;

/// Defines whether the liveness recording video of processing. Defaults to `true`.
@property(readonly, nonatomic, assign, getter=isRecordingProcessEnabled) BOOL recordingProcessEnabled;

/// Defines tag that can be used in Liveness processing. Defaults to `nil`.
@property(readonly, nonatomic, strong, nullable) NSString *tag;

#pragma mark - Camera

/// Defines, whether the camera's toolbar close button is available on the Liveness UI. Defaults to `true`.
/// When set to `false` the CameraToolbarView won't contain a button to close a module
@property(readonly, nonatomic, assign, getter=isCloseButtonEnabled) BOOL closeButtonEnabled;

@end

@interface RFSLivenessConfigurationBuilder ()

/// @see RFSLivenessConfiguration.attemptsCount.
@property(readwrite, nonatomic, assign) NSInteger attemptsCount;
/// @see RFSLivenessConfiguration.locationTrackingEnabled.
@property(readwrite, nonatomic, assign, getter=isLocationTrackingEnabled) BOOL locationTrackingEnabled;
/// @see RFSLivenessConfiguration.recordingProcessEnabled.
@property(readwrite, nonatomic, assign, getter=isRecordingProcessEnabled) BOOL recordingProcessEnabled;
/// @see RFSLivenessConfiguration.closeButtonEnabled.
@property(readwrite, nonatomic, assign, getter=isCloseButtonEnabled) BOOL closeButtonEnabled;
/// @see RFSLivenessConfiguration.tag.
@property(readwrite, nonatomic, strong, nullable) NSString *tag;
/// @see RFSLivenessConfiguration.stepSkippingMask.
@property(readwrite, nonatomic, assign) RFSLivenessStepSkip stepSkippingMask;
/// @see RFSLivenessConfiguration.copyright.
@property(readwrite, nonatomic, assign, getter=isCopyright) BOOL copyright;

@end

NS_ASSUME_NONNULL_END
