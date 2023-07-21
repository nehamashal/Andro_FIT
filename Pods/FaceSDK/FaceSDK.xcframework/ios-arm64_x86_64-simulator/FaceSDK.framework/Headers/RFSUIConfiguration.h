//
//  RFSUIConfiguration.h
//  FaceSDK
//
//  Created by Dmitry Evglevsky on 15.05.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FaceSDK/RFSMacros.h>

typedef NS_ENUM(NSInteger, RFSCustomizationColor) {
    OnboardingScreenStartButtonBackground = 100,
    OnboardingScreenStartButtonTitle = 101,
    OnboardingScreenBackground = 102,
    OnboardingScreenTitleLabelText = 103,
    OnboardingScreenMessageLabelText = 104,
    
    CameraScreenStrokeNormal = 200,
    CameraScreenStrokeActive = 201,
    CameraScreenSectorTarget = 202,
    CameraScreenSectorActive = 203,
    CameraScreenFrontHintLabelBackground = 204,
    CameraScreenFrontHintLabelText = 205,
    CameraScreenBackHintLabelBackground = 206,
    CameraScreenBackHintLabelText = 207,
    CameraScreenLightToolbarTint = 208,
    CameraScreenDarkToolbarTint = 209,
    
    RetryScreenBackground = 300,
    RetryScreenRetryButtonBackground = 301,
    RetryScreenRetryButtonTitle = 302,
    RetryScreenTitleLabelText = 303,
    RetryScreenHintLabelsText = 304,
    
    ProcessingScreenBackground = 400,
    ProcessingScreenProgress = 401,
    ProcessingScreenTitleLabel = 402,
    
    SuccessScreenBackground = 500
} NS_SWIFT_NAME(CustomizationColor);

typedef NS_ENUM(NSInteger, RFSCustomizationImage) {
    OnboardingScreenCloseButton = 100,
    OnboardingScreenIllumination = 101,
    OnboardingScreenAccessories = 102,
    OnboardingScreenCameraLevel = 103,
    
    CameraScreenCloseButton = 200,
    CameraScreenLightOnButton = 201,
    CameraScreenLightOffButton = 202,
    CameraScreenSwitchButton = 203,
    
    RetryScreenCloseButton = 300,
    RetryScreenHintEnvironment = 301,
    RetryScreenHintSubject = 302,
    
    ProcessingScreenCloseButton = 400,
    
    SuccessScreenImage = 500,
} NS_SWIFT_NAME(CustomizationImage);

typedef NS_ENUM(NSInteger, RFSCustomizationFont) {
    OnboardingScreenStartButton = 100,
    OnboardingScreenTitleLabel = 101,
    OnboardingScreenMessageLabel = 102,
    
    CameraScreenHintLabel = 200,
    
    RetryScreenRetryButton = 300,
    RetryScreenTitleLabel = 301,
    RetryScreenHintLabels = 302,
    
    ProcessingScreenLabel = 400
} NS_SWIFT_NAME(CustomizationFont);

NS_ASSUME_NONNULL_BEGIN

@class RFSUIConfigurationBuilder;

NS_SWIFT_NAME(UIConfiguration)
@interface RFSUIConfiguration : NSObject

RFS_EMPTY_INIT_UNAVAILABLE

- (instancetype)initWithBuilder:(RFSUIConfigurationBuilder *)builder NS_DESIGNATED_INITIALIZER;

+ (instancetype)defaultConfiguration;
+ (instancetype)configurationWithBuilderBlock:(void (^)(RFSUIConfigurationBuilder *))builderBlock;

- (UIColor *)colorForItem:(RFSCustomizationColor)item;
- (UIImage *)imageForItem:(RFSCustomizationImage)item;
- (UIFont *)fontForItem:(RFSCustomizationFont)item;

@end

NS_SWIFT_NAME(UIConfigurationBuilder)
@interface RFSUIConfigurationBuilder : NSObject

RFS_EMPTY_INIT_UNAVAILABLE

- (void)setColor:(UIColor *)color forItem:(RFSCustomizationColor)item;
- (void)setImage:(UIImage *)image forItem:(RFSCustomizationImage)item;
- (void)setFont:(UIFont *)font forItem:(RFSCustomizationFont)item;

@end

NS_ASSUME_NONNULL_END
