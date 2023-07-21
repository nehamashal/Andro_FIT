//
//  RFSImageQualityResult.h
//  FaceSDK
//
//  Created by Serge Rylko on 2.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSImageQualityGroup.h>
#import <FaceSDK/RFSImageQualityResultStatus.h>
#import <FaceSDK/RFSImageQualityCharacteristicName.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSImageQualityRange;

/// Quality assessment result.
NS_SWIFT_NAME(ImageQualityResult)
@interface RFSImageQualityResult: NSObject

/// Image quality characteristic group
@property(nonatomic, readonly, assign) RFSImageQualityGroup group;

/// The name of the characteristic.
@property(nonnull, nonatomic, readonly) RFSImageQualityCharacteristicName name;

/// The assessment status of the characteristic
@property(nonatomic, readonly, assign) RFSImageQualityResultStatus status;

/// The assessed value for the characteristic.
@property(nonnull, nonatomic, readonly, strong) NSNumber *value;

/// The range of set values for this characteristic.
@property(nonnull, nonatomic, readonly, strong) RFSImageQualityRange *range;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
