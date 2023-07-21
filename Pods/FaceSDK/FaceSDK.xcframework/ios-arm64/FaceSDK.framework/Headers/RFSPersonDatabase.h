//
//  RFSPersonDatabase.h
//  FaceSDK
//
//  Created by Serge Rylko on 5.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>
#import <FaceSDK/RFSPersonDatabaseInterface.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const RFSPersonDatabaseErrorDomain NS_SWIFT_NAME(PersonDatabaseErrorDomain);

typedef NS_ERROR_ENUM(RFSPersonDatabaseErrorDomain, RFSPersonDatabaseErrorCode) {
  RFSPersonDatabaseErrorCodeAPIFailed
} NS_SWIFT_NAME(PersonDatabase.Error);

NS_SWIFT_NAME(PersonDatabase)
/// `RFSPersonDatabase` represents Regula Database layer and is the entry point for Person Database operations.
@interface RFSPersonDatabase : NSObject <RFSPersonDatabaseInterface>

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
