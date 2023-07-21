//
//  RFSPersonGroup.h
//  FaceSDK
//
//  Created by Serge Rylko on 5.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>
#import <FaceSDK/RFSDBBaseItem.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PersonDatabase.PersonGroup)
/// Person Database object that represents Group of persons.
@interface RFSPersonGroup : RFSDBBaseItem

/// PersonGroup name.
/// Updatable fields.
@property (nonatomic, strong) NSString *name;

/// A free-form object containing Group extended attributes.
/// Updatable field.
@property (nonatomic, strong) NSMutableDictionary *metadata;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
