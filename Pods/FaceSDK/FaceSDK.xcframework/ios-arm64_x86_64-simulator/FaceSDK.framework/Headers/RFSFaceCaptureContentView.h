//
//  RFSFaceCaptureContentView.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 4/30/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RFSCameraToolbarView.h"
#import "RFSPassthroughView.h"
#import "RFSHintView.h"
#import "RFSOverriding.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RFSFaceCaptureContentViewState) {
    RFSFaceCaptureContentViewStateFront,
    RFSFaceCaptureContentViewStateRear,
} NS_SWIFT_NAME(FaceCaptureContentViewState);

NS_SWIFT_NAME(FaceCaptureContentView)
@interface RFSFaceCaptureContentView : RFSPassthroughView <RFSOverriding>

/// Instructions for face detection.
/// Does not support overrding.
@property(readonly, nonatomic, nonnull) RFSHintView *hintView;

/// Toolbar with control buttons.
/// Does not support direct overrding – use Configuration's `registerClass` method in order to provide your implementation.
@property(readonly, nonatomic, nonnull) RFSCameraToolbarView *toolbarView;

#pragma mark - Styling

- (void)setBackgroundColor:(nullable UIColor *)color forState:(RFSFaceCaptureContentViewState)state UI_APPEARANCE_SELECTOR;
- (nullable UIColor *)backgroundColorForState:(RFSFaceCaptureContentViewState)state UI_APPEARANCE_SELECTOR;

#pragma mark - Overridable

/// Setups default constraints. Can be overriden to provide custom layout constraints.
- (void)setupConstraints;

@end

NS_ASSUME_NONNULL_END
