//
//  RFSPersonDatabaseInterface.h
//  FaceSDK
//
//  Created by Serge Rylko on 12.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSPersonDatabaseCompletion.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSImageUpload;
@class RFSSearchPersonRequest;
@class RFSEditGroupPersonsRequest;

NS_SWIFT_NAME(PersonDatabaseInterface)
@protocol RFSPersonDatabaseInterface

#pragma mark - Persons

- (void)getPersonByPersonId:(NSString *)personId
                 completion:(RFSPersonCompletion)completion NS_SWIFT_NAME(getPerson(personId:completion:));
- (void)createPersonWithName:(NSString *)name
                    metadata:(nullable NSDictionary *)metadata
                    groupIds:(nullable NSArray<NSString *> *)groupIds
                  completion:(RFSPersonCompletion)completion NS_SWIFT_NAME(createPerson(name:metadata:groupIds:completion:));
- (void)updatePerson:(RFSPerson *)person
          completion:(RFSConfirmCompletion)completion NS_SWIFT_NAME(updatePerson(person:completion:));
- (void)deletePersonByPersonId:(NSString *)personId
                    completion:(RFSConfirmCompletion)completion NS_SWIFT_NAME(deletePerson(personId:completion:));

#pragma mark - PersonImages
- (void)getPersonImagesByPersonId:(NSString *)personId
                       completion:(RFSPersonImageListPageCompletion)completion NS_SWIFT_NAME(getPersonImages(personId:completion:));
- (void)getPersonImagesByPersonId:(NSString *)personId
                             page:(NSInteger)page
                             size:(NSInteger)size
                       completion:(RFSPersonImageListPageCompletion)completion NS_SWIFT_NAME(getPersonImages(personId:page:size:completion:));
- (void)addPersonImageByPersonId:(NSString *)personId
                     imageUpload:(RFSImageUpload *)imageUpload
                      completion:(RFSPersonImageCompletion)completion NS_SWIFT_NAME(addPersonImage(personId:imageUpload:completion:));
- (void)getPersonImageByPersonId:(NSString *)personId
                         imageId:(NSString *)imageId
                      completion:(RFSSearchDataCompletion)completion NS_SWIFT_NAME(getPersonImage(personId:imageId:completion:));
- (void)deletePersonImageByPersonId:(NSString *)personId
                            imageId:(NSString *)imageId
                         completion:(RFSConfirmCompletion)completion NS_SWIFT_NAME(deletePersonImage(personId:imageId:completion:));

#pragma mark - PersonGroups
- (void)getGroups:(RFSPersonGroupListPageCompletion)completion NS_SWIFT_NAME(getGroups(completion:));
- (void)getGroupsForPage:(NSInteger)page
                    size:(NSInteger)size
              completion:(RFSPersonGroupListPageCompletion)completion NS_SWIFT_NAME(getGroups(page:size:completion:));;
- (void)getPersonGroupsByPersonId:(NSString *)personId
                       completion:(RFSPersonGroupListPageCompletion)completion NS_SWIFT_NAME(getPersonGroups(personId:completion:));
- (void)getPersonGroupsByPersonId:(NSString *)personId
                             page:(NSInteger)page
                             size:(NSInteger)size
                       completion:(RFSPersonGroupListPageCompletion)completion NS_SWIFT_NAME(getPersonGroups(personId:page:size:completion:));
- (void)createGroupWithName:(NSString *)name
                   metadata:(nullable NSDictionary *)metadata
                 completion:(RFSPersonGroupCompletion)completion NS_SWIFT_NAME(createGroup(name:metadata:completion:));
- (void)getGroupByGroupId:(NSString *)groupId
               completion:(RFSPersonGroupCompletion)completion NS_SWIFT_NAME(getGroups(groupId:completion:));
- (void)updateGroup:(RFSPersonGroup *)group
         completion:(RFSConfirmCompletion)completion NS_SWIFT_NAME(updateGroup(group:completion:));
- (void)editGroupPersonsByGroupId:(NSString *)groupId
                          request:(RFSEditGroupPersonsRequest *)request
                       completion:(RFSConfirmCompletion)completion NS_SWIFT_NAME(editGroupPersons(groupId:request:completion:));
- (void)getGroupPersonsByGroupId:(NSString *)groupId
                      completion:(RFSPersonListPageCompletion)completion NS_SWIFT_NAME(getGroupPersons(groupId:completion:));
- (void)getGroupPersonsByGroupId:(NSString *)groupId
                            page:(NSInteger)page
                            size:(NSInteger)size
                      completion:(RFSPersonListPageCompletion)completion NS_SWIFT_NAME(getGroupPersons(groupId:page:size:completion:));
- (void)deleteGroupByGroupId:(NSString *)groupId
                  completion:(RFSConfirmCompletion)completion NS_SWIFT_NAME(deleteGroup(groupId:completion:));

#pragma mark - Search
- (void)searchPerson:(RFSSearchPersonRequest *)searchRequest
          completion:(RFSSearchPersonCompletion)completion NS_SWIFT_NAME(searchPerson(searchRequest:completion:));

@end

NS_ASSUME_NONNULL_END
