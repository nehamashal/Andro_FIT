//
//  RFSFaceSDK.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 5/19/19.
//  Copyright © 2019 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@class NSURLRequest;
@class RFSLivenessConfiguration;
@class RFSFaceCaptureConfiguration;
@class RFSMatchFacesRequest;
@class RFSMatchFacesResponse;
@class RFSFaceCaptureResponse;
@class RFSLivenessResponse;
@class RFSDetectFacesRequest;
@class RFSDetectFacesResponse;
@class RFSCustomization;
@class RFSPersonDatabase;

@protocol RFSURLRequestInterceptingDelegate;

/// Liveness process statuses.
typedef NS_ENUM(NSUInteger, RFSLivenessProcessStatus) {
    RFSLivenessProcessStatusStart,
    RFSLivenessProcessStatusPreparing,
    RFSLivenessProcessStatusNewSession,
    RFSLivenessProcessStatusProgress,
    RFSLivenessProcessStatusNextStage,
    RFSLivenessProcessStatusSectorChanged,
    RFSLivenessProcessStatusProcessing,
    RFSLivenessProcessStatusLowBrightness,
    RFSLivenessProcessStatusFitFace,
    RFSLivenessProcessStatusMoveAway,
    RFSLivenessProcessStatusMoveCloser,
    RFSLivenessProcessStatusTurnHead,
    RFSLivenessProcessStatusFailed,
    RFSLivenessProcessStatusRetry,
    RFSLivenessProcessStatusSuccess
} NS_SWIFT_NAME(LivenessProcessStatus);

NS_SWIFT_NAME(LivenessProcessStatusDelegate)
@protocol RFSLivenessProcessStatusDelegate <NSObject>

- (void)processStatusChanged:(RFSLivenessProcessStatus)status result:(RFSLivenessResponse * _Nullable)result;

@end

NS_SWIFT_NAME(VideoUploadingDelegate)
@protocol RFSVideoUploadingDelegate <NSObject>

- (void)videoUploadingForTransactionId:(NSString * _Nonnull)transactionId didFinishedWithSuccess:(BOOL)success;

@end

/// `RFSFaceErrorDomain` indicates an error related to the Face SDK. For error codes see `RFSFaceError`.
FOUNDATION_EXPORT NSErrorDomain const _Nonnull RFSFaceErrorDomain NS_SWIFT_NAME(FaceErrorDomain);

typedef NS_ERROR_ENUM(RFSFaceErrorDomain, RFSFaceErrorCode) {
    RFSFaceErrorAlreadyRunning,
    RFSFaceErrorMissingCore,
    RFSFaceErrorInternalCoreError
} NS_SWIFT_NAME(FaceError);

typedef void (^RFSFaceInitializationCompletion)(BOOL success, NSError * _Nullable error) NS_SWIFT_NAME(FaceInitializationCompletion);

/// The entry point to the Face SDK features.
NS_SWIFT_NAME(FaceSDK)
@interface RFSFaceSDK : NSObject

/// A shared instance of `RFSFaceSDK`.
@property(readonly, class, nonatomic, strong, nonnull) RFSFaceSDK *service;

@property(readonly, nonatomic, strong, nonnull) RFSPersonDatabase* personDatabase;

/// An URL of your web service instance.
@property(readwrite, nonatomic, copy, nullable) NSString *serviceURL;

/// The Face SDK version.
@property(readonly, nonatomic, strong, nullable) NSString *version;

/// A localization hook to override default localization search logic.
/// If this block is not set or the implementation of the block returns `nil` the default localization will be used.
@property(readwrite, nonatomic, copy, nullable) NSString * _Nullable (^localizationHandler)(NSString * _Nonnull localizationKey);

/// Delegate that responds to request intercepting events.
/// Use the delegate to modify `URLRequest` requests before they are send to the web service.
@property(readwrite, nonatomic, weak, nullable) id<RFSURLRequestInterceptingDelegate> requestInterceptingDelegate;

/// Delegate that informs about the liveness process statuses.
@property(readwrite, nonatomic, weak, nullable) id<RFSLivenessProcessStatusDelegate> processStatusDelegate;

/// Delegate that informs about the successfull upload of the video.
@property(readwrite, nonatomic, weak, nullable) id<RFSVideoUploadingDelegate> videoUploadingDelegate;

/// Liveness and Face Capture view controller customization and etc.
@property(readwrite, nonatomic, strong, nonnull) RFSCustomization *customization;

- (void)initializeWithCompletion:(RFSFaceInitializationCompletion _Nonnull)completion NS_SWIFT_NAME(initialize(completion:));

/// Processes given `RFSMatchFacesRequest` and calls back the `completionHandler` block when finished.
/// @param request Processing request.
/// @param completionHandler Completion block to call when request is finished processing.
- (void)matchFaces:(nonnull RFSMatchFacesRequest *)request
        completion:(void (^ _Nonnull)(RFSMatchFacesResponse * _Nonnull response))completionHandler;

/// Presents a liveness view controller.
/// @param presenting The `UIViewController` that will present the liveness view controller.
/// @param animated Pass `true` to animate the presentation otherwise, pass `false`.
/// @param onLiveness Liveness response.
/// @param configuration Configuration object. Falls back to the default configuration when `nil`.
/// @param completion Presentation transition completion block.
- (void)startLivenessFrom:(nonnull UIViewController *)presenting
                 animated:(BOOL)animated
            configuration:(nullable RFSLivenessConfiguration *)configuration
               onLiveness:(nullable void (^)(RFSLivenessResponse * _Nonnull))onLiveness
               completion:(nullable void (^)(void))completion;


 /// Presents a liveness view controller
 /// @param presenting The `UIViewController` that will present the liveness view controller.
 /// @param animated Pass `true` to animate the presentation otherwise, pass `false`.
 /// @param onLiveness Completion block to call when the liveness is finished processing.
 /// @param completion Presentation transition completion block.
- (void)startLivenessFrom:(nonnull UIViewController *)presenting
                 animated:(BOOL)animated
               onLiveness:(nullable void (^)(RFSLivenessResponse * _Nonnull))onLiveness
               completion:(nullable void (^)(void))completion;

/// Stops the liveness processing and closes the view controller.
- (void)stopLivenessProcessing;
/// Processes given `request` and calls back the `completionHandler` block when finished.
/// Requires network connection.
/// @param request Processing request.
/// @param completion Completion block to call when request is finished processing.
- (void)detectFacesByRequest:(nonnull RFSDetectFacesRequest *) request
                  completion:(nonnull void(^)(RFSDetectFacesResponse * _Nonnull))completion;

/// Presents face capturing view controller
/// @param presenting The `UIViewController` that will present face capturing view controller
/// @param animated Pass `true` to animate the presentation otherwise, pass `false`.
/// @param configuration Configuration object. Falls back to the default configuration when `nil`.
/// @param onCapture Completion block to call when the face capture is finished processing.
/// @param completion Presentation transition completion block.
- (void)presentFaceCaptureViewControllerFrom:(nonnull UIViewController *)presenting
                                    animated:(BOOL)animated
                               configuration:(nullable RFSFaceCaptureConfiguration *)configuration
                                   onCapture:(nullable void (^)(RFSFaceCaptureResponse * _Nonnull))onCapture
                                  completion:(nullable void (^)(void))completion;

 /// Presents a face capturing view controller
 /// @param presenting The `UIViewController` that will present face capturing view controller
 /// @param animated Pass `true` to animate the presentation otherwise, pass `false`.
 /// @param onCapture Completion block to call when the face capture is finished processing.
 /// @param completion Presentation transition completion block.
- (void)presentFaceCaptureViewControllerFrom:(nonnull UIViewController *)presenting
                                    animated:(BOOL)animated
                                   onCapture:(nullable void (^)(RFSFaceCaptureResponse * _Nonnull))onCapture
                                  completion:(nullable void (^)(void))completion;

/// Stops the face capturing and closes the view controller.
- (void)stopFaceCaptureViewController;

/// FaceSDK deinitialization.
- (void)deinitialize;

@end
