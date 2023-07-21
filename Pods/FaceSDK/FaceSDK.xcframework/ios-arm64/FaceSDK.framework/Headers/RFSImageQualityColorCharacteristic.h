//
//  RFSImageQualityColorCharacteristic.h
//  FaceSDK
//
//  Created by Serge Rylko on 16.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <FaceSDK/RFSImageQualityCharacteristic.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class UIColor;

/// Image Quality Characteristic where a color is the parameter for Assessment.
NS_SWIFT_NAME(ImageQualityColorCharacteristic)
@interface RFSImageQualityColorCharacteristic : RFSImageQualityCharacteristic

/// Color  value for Characteristic Assessment.
@property(nonnull, nonatomic, readonly, copy) UIColor *color;

@end

NS_ASSUME_NONNULL_END
