//
//  RFSDeprecated.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 24/11/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <FaceSDK/RFSMatchFacesRequest.h>
#import <FaceSDK/RFSMatchFacesResponse.h>
#import <FaceSDK/RFSMatchFacesComparedFace.h>
#import <FaceSDK/RFSImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFSMatchFacesRequest (Deprecated)

/// The threshold value of the similarity of faces. Defaults to `0.75`.
/// If the similarity of faces is greater or equal than the threshold, faces will be stored to the `matchedFaces` array, otherwise to the `unmatchedFaces` one.
@property(nonatomic, readwrite, strong, nonnull) NSNumber *similarityThreshold RFS_DEPRECATED(3.2, "Use `+[RFSMatchFacesSimilarityThresholdSplit splitPairs:bySimilarityThreshold:]` instead.");

@end

@interface RFSMatchFacesResponse (Deprecated)

/// Matched pairs of faces with similarity is greater or equal than the value of `similarityThreshold`.
@property(readonly, nonatomic, strong, nonnull) NSArray<RFSMatchFacesComparedFacesPair *> *matchedFaces RFS_DEPRECATED(3.2, "Use `+[RFSMatchFacesSimilarityThresholdSplit splitPairs:bySimilarityThreshold:]` instead.");

/// Unmatched pairs of faces which similarity is less than the value of `similarityThreshold`.
@property(readonly, nonatomic, strong, nonnull) NSArray<RFSMatchFacesComparedFacesPair *> *unmatchedFaces RFS_DEPRECATED(3.2, "Use `+[RFSMatchFacesSimilarityThresholdSplit splitPairs:bySimilarityThreshold:]` instead.");

@end

@interface RFSMatchFacesComparedFace (Deprecated)

/// The image type.
@property(nonatomic, readonly, assign) RFSImageType imageType RFS_DEPRECATED(3.2, "Use `image.imageType` instead.");

/// The index of a ComparedFace object in the images array provided to the request.
@property(nonatomic, readonly, strong, nullable) NSNumber *position RFS_DEPRECATED(3.2, "Use `imageIndex` or `image` instead.");

@end

@interface RFSImage (Deprecated)

/// The string that is used for objects tagging.
/// Use this field to match the output and input data.
@property(nonatomic, readwrite, copy, nullable) NSString *tag RFS_DEPRECATED(3.2, "Use `identifier` for input matching instead.");

@end

NS_ASSUME_NONNULL_END
