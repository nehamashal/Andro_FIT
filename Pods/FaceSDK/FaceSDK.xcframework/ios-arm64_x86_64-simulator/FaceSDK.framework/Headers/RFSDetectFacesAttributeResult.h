//
//  RFSDetectFacesAttributeResult.h
//  FaceSDK
//
//  Created by Serge Rylko on 15.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>
#import <FaceSDK/RFSDetectFacesAttribute.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSImageQualityRange;

NS_SWIFT_NAME(DetectFacesAttributeResult)
@interface RFSDetectFacesAttributeResult: NSObject

@property(nonnull, nonatomic, readonly) RFSDetectFacesAttribute attribute;
@property(nullable, nonatomic, readonly) NSNumber *confidence;
@property(nullable, nonatomic, readonly) NSString *value;
@property(nullable, nonatomic, readonly) RFSImageQualityRange *range;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
