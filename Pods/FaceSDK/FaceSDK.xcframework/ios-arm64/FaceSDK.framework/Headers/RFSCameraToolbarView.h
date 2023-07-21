//
//  RFSCameraToolbarView.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 6/23/19.
//  Copyright © 2019 Regula. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FaceSDK/RFSOverriding.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RFSCameraToolbarViewState) {
    RFSCameraToolbarViewStateFront,
    RFSCameraToolbarViewStateRear,
} NS_SWIFT_NAME(CameraToolbarViewState);

NS_SWIFT_NAME(CameraToolbarView)
@interface RFSCameraToolbarView : UIView <RFSOverriding>

@property(readwrite, nonatomic, assign) RFSCameraToolbarViewState state;

#pragma mark - Overriding

/// Defaults to not `nil`. Can be overriden directly or set to `nil` to hide a button from the toolbar.
@property(readonly, nonatomic, nullable) UIButton *torchButton;

/// Defaults to not `nil`. Can be overriden directly or set to `nil` to hide a button from the toolbar.
@property(readonly, nonatomic, nullable) UIButton *switchCameraButton;

/// Defaults to not `nil`. Can be overriden directly or set to `nil` to hide a button from the toolbar.
@property(readonly, nonatomic, nullable) UIButton *closeButton;

/// Setups default constraints. Can be overriden to provide custom layout constraints.
- (void)setupConstraints;

/// Updates CameraToolbarView state. Called when `state` propperty is changed.
/// Can be overriden to provide custom appearance for different states of ToolbarView.
- (void)updateState:(RFSCameraToolbarViewState)state;

#pragma mark - Styling

- (void)setTintColor:(nullable UIColor *)color forState:(RFSCameraToolbarViewState)state UI_APPEARANCE_SELECTOR;
- (nullable UIColor *)tintColorForState:(RFSCameraToolbarViewState)state UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
