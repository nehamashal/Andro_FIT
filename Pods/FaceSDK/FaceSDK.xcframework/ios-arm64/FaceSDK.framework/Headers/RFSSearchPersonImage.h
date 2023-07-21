//
//  RFSSearchPersonImage.h
//  FaceSDK
//
//  Created by Serge Rylko on 18.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>
#import <FaceSDK/RFSPersonImage.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PersonDatabase.SearchPersonImage)
/// A Person Database object that represents Image result of Person Search.
@interface RFSSearchPersonImage : RFSPersonImage

/// The similarity score.
/// From 0.0 to 1.0.
@property (nonatomic, strong, readonly) NSNumber *similarity;

/// The similarity distance score.
/// The lower the distance, the higher the face's similarity.
/// From 0.0 to 2.0.
@property (nonatomic, strong, readonly) NSNumber *distance;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
