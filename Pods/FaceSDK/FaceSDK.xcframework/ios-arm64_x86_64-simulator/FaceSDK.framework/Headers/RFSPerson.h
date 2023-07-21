//
//  RFSPerson.h
//  FaceSDK
//
//  Created by Serge Rylko on 5.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>
#import <FaceSDK/RFSDBBaseItem.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PersonDatabase.Person)
/// A Person Database object that represents Person.
@interface RFSPerson : RFSDBBaseItem

/// Person name.
/// Updatable field.
@property (nonatomic, strong) NSString *name;

/// Person update date.
@property (nonatomic, strong, readonly) NSDate *updatedAt;

/// Array if Group IDs Person belongs to.
@property (nonatomic, strong, readonly) NSArray<NSString *> *groups;

/// A free-form object containing Person extended attributes.
/// Updatable field.
@property (nonatomic, strong) NSMutableDictionary *metadata;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
