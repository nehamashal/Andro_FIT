//
//  RFSImageQualityRange.h
//  FaceSDK
//
//  Created by Serge Rylko on 2.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

/// Base range value for Image Quality parameters
NS_SWIFT_NAME(ImageQualityRange)
@interface RFSImageQualityRange: NSObject

/// Minimum range value.
@property(nonnull, nonatomic, readonly, strong) NSNumber *min;

/// Maximum range value.
@property(nonnull, nonatomic, readonly, strong) NSNumber *max;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
