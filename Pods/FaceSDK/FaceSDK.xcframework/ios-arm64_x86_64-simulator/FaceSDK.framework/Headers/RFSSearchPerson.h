//
//  RFSSearchPerson.h
//  FaceSDK
//
//  Created by Serge Rylko on 17.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>
#import <FaceSDK/RFSPerson.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSSearchPersonImage;
@class RFSSearchPersonDetection;

NS_SWIFT_NAME(PersonDatabase.SearchPerson)
/// A Person Database object that represents th result of Person search.
@interface RFSSearchPerson : RFSPerson

/// Array of images where the Person is found.
@property (nonatomic, strong, readonly) NSArray<RFSSearchPersonImage *> *images;

/// Detection data relative to the search input image.
@property (nonatomic, strong, readonly) RFSSearchPersonDetection *detection;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
