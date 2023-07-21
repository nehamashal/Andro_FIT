//
//  RFSPersonDatabaseCompletion.h
//  FaceSDK
//
//  Created by Serge Rylko on 6.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSDatabaseResponse.h>
#import <FaceSDK/RFSPerson.h>
#import <FaceSDK/RFSPersonGroup.h>
#import <FaceSDK/RFSPersonImage.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^RFSConfirmCompletion)(RFSComfirmResponse *response) NS_SWIFT_NAME(PersonDatabase.DatabaseCompletion);

typedef void (^RFSPersonCompletion)(RFSItemResponse<RFSPerson *> *response) NS_SWIFT_NAME(PersonDatabase.PersonCompletion);
typedef void (^RFSPersonGroupCompletion)(RFSItemResponse<RFSPersonGroup *> *response) NS_SWIFT_NAME(PersonDatabase.PersonGroupCompletion);
typedef void (^RFSPersonImageCompletion)(RFSItemResponse<RFSPersonImage *> *response) NS_SWIFT_NAME(PersonDatabase.PersonImageCompletion);

typedef void (^RFSPersonListPageCompletion)(RFSPageResponse<RFSPerson *> *) NS_SWIFT_NAME(PersonDatabase.PersonListPageCompletion);
typedef void (^RFSPersonGroupListPageCompletion)(RFSPageResponse<RFSPersonGroup *> *) NS_SWIFT_NAME(PersonDatabase.PersonGroupListPageCompletion);
typedef void (^RFSPersonImageListPageCompletion)(RFSPageResponse<RFSPersonImage *> *) NS_SWIFT_NAME(PersonDatabase.PersonImageListPageCompletion);

typedef void (^RFSSearchPersonCompletion)(RFSSearchPersonResponse *response) NS_SWIFT_NAME(PersonDatabase.SearchPersonCompletion);

typedef void (^RFSSearchDataCompletion)(RFSDataResponse *response) NS_SWIFT_NAME(PersonDatabase.SearchDataCompletion);

NS_ASSUME_NONNULL_END
