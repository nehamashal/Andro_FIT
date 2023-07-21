//
//  RFSCustomization.h
//  FaceSDK
//
//  Created by Dmitry Evglevsky on 24.02.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RFSUIConfiguration;

/// Tags can be used to override SDK's camera view controller buttons. Hide overroden button via RGLFunctionality.
typedef NS_ENUM(NSInteger, RFSCustomButtonTag) {
  RFSCustomButtonTagClose = 1001,
  RFSCustomButtonTagTorch = 1002,
  RFSCustomButtonTagCameraSwitch = 1003,
} NS_SWIFT_NAME(FaceSDK.CustomButtonTag);

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(FaceSDK.CustomizationActionDelegate)
@protocol RFSCustomizationActionDelegate <NSObject>

- (void)onFaceCustomButtonTappedWithTag:(NSInteger)tag;

@end

@interface RFSCustomization : NSObject

@property(nonatomic, strong, nullable) RFSUIConfiguration *configuration;

@property(nonatomic, weak, nullable) id<RFSCustomizationActionDelegate> actionDelegate;

@property(nonatomic, strong, nullable) NSDictionary *customUILayerJSON;

@end

NS_ASSUME_NONNULL_END
