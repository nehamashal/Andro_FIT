//
//  RFSCameraOverlayView.h
//  FaceSDK
//
//  Created by Dmitry Smolyakov on 10/21/20.
//  Copyright © 2020 Regula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFSPassthroughView.h"

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(CameraOverlayView)
@interface RFSCameraOverlayView : RFSPassthroughView

#pragma mark - Styling

@property(readwrite, nonatomic, assign) CGFloat strokeWidth UI_APPEARANCE_SELECTOR;
@property(readwrite, nonatomic, assign) CGFloat strokeWidthActive UI_APPEARANCE_SELECTOR;
@property(readwrite, nonatomic, assign) CGFloat strokeOffset UI_APPEARANCE_SELECTOR;
@property(readwrite, nonatomic, strong) UIColor *strokeColor UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
