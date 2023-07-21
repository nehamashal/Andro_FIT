//
//  RFSEditGroupPersonsRequest.h
//  FaceSDK
//
//  Created by Serge Rylko on 16.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSEditGroupPersonsRequest;

NS_SWIFT_NAME(PersonDatabase.EditGroupPersonsRequest)
/// Request object to configure PersonGroup editing.
@interface RFSEditGroupPersonsRequest : NSObject

/// Array of Person IDs to add to the group.
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *personIdsToAdd;

/// Array of Person IDs to remove from the group.
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *personIdsToRemove;

/// Creates request for PersonGroup editing
/// - Parameters:
///   - personIdsToAdd: Array of Person IDs to add to the group.
///   - personIdsToRemove: Array of Person IDs to remove from the group.
- (instancetype)initWithPersonIdsToAdd:(nullable NSArray<NSString *> *)personIdsToAdd
                     personIdsToRemove:(nullable NSArray<NSString *> *)personIdsToRemove;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
