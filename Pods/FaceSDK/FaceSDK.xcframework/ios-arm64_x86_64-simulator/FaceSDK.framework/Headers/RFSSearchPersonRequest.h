//
//  RFSSearchPersonRequest.h
//  FaceSDK
//
//  Created by Serge Rylko on 14.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSImageUpload;
@class RFSOutputImageParams;

NS_SWIFT_NAME(PersonDatabase.SearchPersonRequest)
/// Request object that configures Search settings.
@interface RFSSearchPersonRequest : NSObject

/// The Group IDs of the groups in which the search is performed.
@property (nullable, nonatomic, strong) NSArray<NSString *> *groupIdsForSearch;

/// The similarity distance threshold, should be between 0.0 and 2.0,
/// where 0.0 is for returning results for only the most similar persons and 2.0 is for all the persons, even the dissimilar ones.
/// Default: 1
@property (nullable, nonatomic, strong) NSNumber *threshold;

/// The number of returned Persons limit.
/// Default: 100.
@property (nullable, nonatomic, strong) NSNumber *limit;

/// Whether to process only the one face on the image or all the faces.
/// Default: NO
@property (nonatomic, assign) BOOL detectAll;

/// If set. the uploaded image is processed according to the indicated settings
@property (nullable, nonatomic, strong) RFSOutputImageParams *outputImageParams;

/// Image Upload object to appply search with.
@property (nonatomic, strong, readonly) RFSImageUpload *imageUpload;

/// Creates new Search request.
/// The request will perform search only in specified groups.
/// - Parameters:
///   - groupIdsForSearch: The Group IDs of the groups in which the search is performed.
///   - imageUpload: mage Upload object to appply search with.
- (instancetype)initWithGroupIds:(nullable NSArray<NSString *> *)groupIdsForSearch
                     imageUpload:(RFSImageUpload *)imageUpload;

- (instancetype)initWithImageUpload:(RFSImageUpload *)imageUpload;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
