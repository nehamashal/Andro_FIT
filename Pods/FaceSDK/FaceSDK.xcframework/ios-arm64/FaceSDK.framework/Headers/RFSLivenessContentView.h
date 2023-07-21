//
//  RFSLivenessContentView.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 4/26/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FaceSDK/RFSCameraToolbarView.h>
#import <FaceSDK/RFSPassthroughView.h>
#import <FaceSDK/RFSHintView.h>
#import <FaceSDK/RFSOverriding.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(LivenessContentView)
@interface RFSLivenessContentView : RFSPassthroughView <RFSOverriding>

/// Instructions for face detection.
/// Does not support overrding.
@property(readonly, nonatomic, nonnull) RFSHintView *hintView;

/// Toolbar with control buttons.
/// Does not support direct overrding – use Configuration's `registerClass` method in order to provide your implementation.
@property(readonly, nonatomic, nonnull) RFSCameraToolbarView *toolbarView;

#pragma mark - Overridable

/// Setups default constraints. Can be overriden to provide custom layout constraints.
- (void)setupConstraints;

@end

NS_ASSUME_NONNULL_END
