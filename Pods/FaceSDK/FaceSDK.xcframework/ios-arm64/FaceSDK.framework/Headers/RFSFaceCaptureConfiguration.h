//
//  RFSFaceCaptureConfiguration.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 4/16/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FaceSDK/RFSBaseConfiguration.h>
#import <FaceSDK/RFSCameraPosition.h>

NS_ASSUME_NONNULL_BEGIN

/// Mutable builder part of the `RFSFaceCaptureConfiguration`.
NS_SWIFT_NAME(FaceCaptureConfigurationBuilder)
@interface RFSFaceCaptureConfigurationBuilder: RFSBaseConfigurationBuilder
@end

/// Configuration for the FaceCapture.
///
/// This class is used as a parameters for `-[RFSFaceSDK presentFaceCaptureViewControllerFrom:animated:configuration:onCapture:completion:]`.
/// The configuration provides convenient properties to change the behavior and the appearance of the FaceCapture UI module.
NS_SWIFT_NAME(FaceCaptureConfiguration)
@interface RFSFaceCaptureConfiguration : RFSBaseConfiguration<RFSFaceCaptureConfigurationBuilder *> <NSObject>

@property(readonly, nonatomic, nullable) NSNumber *timeoutInterval;

#pragma mark - Camera

/// Defines, whether the logo is visible on the bottom of Face Capture UI screens. Defaults to `true`.
@property(readonly, nonatomic, assign, getter=isCopyright) BOOL copyright;
/// Defines, whether the camera's toolbar switch camera button is available on the FaceCapture UI. Defaults to `false`.
/// When set to `true` the CameraToolbarView will contain a button to change current `cameraPosition`.
@property(readonly, nonatomic, assign, getter=isCameraSwitchButtonEnabled) BOOL cameraSwitchButtonEnabled;
/// Defines, whether the camera's toolbar torch button is available on the FaceCapture UI. Defaults to `true`.
/// When set to `false` the CameraToolbarView won't contain a button to toggle camera's flashlight.
@property(readonly, nonatomic, assign, getter=isTorchButtonEnabled) BOOL torchButtonEnabled;
/// Defines, whether the camera's toolbar close button is available on the FaceCapture UI. Defaults to `true`.
/// When set to `false` the CameraToolbarView won't contain a button to close a module
@property(readonly, nonatomic, assign, getter=isCloseButtonEnabled) BOOL closeButtonEnabled;
/// Selected camera device position. Defaults to `.front`.
@property(readonly, nonatomic, assign) RFSCameraPosition cameraPosition;

@end

@interface RFSFaceCaptureConfigurationBuilder ()

/// @see RFSFaceCaptureConfiguration.copyright.
@property(readwrite, nonatomic, assign, getter=isCopyright) BOOL copyright;
/// @see RFSFaceCaptureConfiguration.cameraSwitchButtonEnabled.
@property(readwrite, nonatomic, assign, getter=isCameraSwitchButtonEnabled) BOOL cameraSwitchButtonEnabled;
/// @see RFSFaceCaptureConfiguration.torchButtonEnabled.
@property(readwrite, nonatomic, assign, getter=isTorchButtonEnabled) BOOL torchButtonEnabled;
/// @see RFSFaceCaptureConfiguration.closeButtonEnabled.
@property(readwrite, nonatomic, assign, getter=isCloseButtonEnabled) BOOL closeButtonEnabled;
/// @see RFSFaceCaptureConfiguration.cameraPosition.
@property(readwrite, nonatomic, assign) RFSCameraPosition cameraPosition;

@property(readwrite, nonatomic, nullable) NSNumber *timeoutInterval;

@end

NS_ASSUME_NONNULL_END
