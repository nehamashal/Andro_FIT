//
//  RFSDBBaseItem.h
//  FaceSDK
//
//  Created by Serge Rylko on 5.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PersonDatabase.DBBaseItem)
/// A base class for Person Database object
@interface RFSDBBaseItem : NSObject

/// The object ID of Person Database object.
@property (nonatomic, strong, readonly) NSString *itemId;

/// A free-form object containing extended attributes.
@property (nonatomic, strong, readonly) NSDictionary *metadata;

/// Creation date of Person Database object.
@property (nonatomic, strong, readonly) NSDate *createdAt;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_ASSUME_NONNULL_END
