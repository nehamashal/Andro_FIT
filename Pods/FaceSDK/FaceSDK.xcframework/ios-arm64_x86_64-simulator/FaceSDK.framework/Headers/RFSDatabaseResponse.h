//
//  RFSSearchResponse.h
//  FaceSDK
//
//  Created by Serge Rylko on 7.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>
#import <FaceSDK/RFSDBBaseItem.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSPerson;
@class RFSPersonGroup;
@class RFSPersonImage;
@class RFSSearchPerson;


NS_SWIFT_NAME(DBBaseResponse)
/// Abstract base response for PersonDatabase requests.
@interface RFSBaseResponse : NSObject

/// The error describes a failed match faces request and contains `RFSPersonDatabaseErrorCode` codes.
/// This error belongs to the `RFSPersonDatabaseErrorDomain`.
@property (nullable, nonatomic, strong, readonly) NSError *error;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_SWIFT_NAME(DBPageResponse)
/// Response for paged requests.
@interface RFSPageResponse<PageItem: RFSDBBaseItem *> : RFSBaseResponse

/// List of result items.
@property (nullable, nonatomic, strong, readonly) NSArray<PageItem> *items;

/// Current page number.
@property (nonatomic, assign, readonly) NSInteger page;

/// Total number of pages.
@property (nonatomic, assign, readonly) NSInteger totalPages;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_SWIFT_NAME(BDItemResponse)
/// Response for single item request.
@interface RFSItemResponse<Item: RFSDBBaseItem *> : RFSBaseResponse

@property (nullable, nonatomic, strong, readonly) Item item;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_SWIFT_NAME(PersonDatabase.Response)
/// Boolean response for PersonDatabase requests.
@interface RFSComfirmResponse : RFSBaseResponse

@property (nonatomic, assign, readonly) BOOL success;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_SWIFT_NAME(PersonDatabase.DataResponse)
/// Data response for PersonDatabase requests.
@interface RFSDataResponse : RFSBaseResponse

@property (nullable, nonatomic, strong, readonly) NSData *data;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_SWIFT_NAME(PersonDatabase.SearchPersonResponse)
/// Response for `RFSSearchPersonRequest`.
@interface RFSSearchPersonResponse : RFSBaseResponse

@property (nullable, nonatomic, strong, readonly) NSArray<RFSSearchPerson *> *results;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_ASSUME_NONNULL_END
