//
//  RFSMatchFacesSimilarityThresholdSplit.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 24/11/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSMatchFacesComparedFacesPair;

/// `RFSMatchFacesSimilarityThresholdSplit` is a result of a splits operation
/// Use splitPairs operation on matched faces pairs with similarityThreshold to split the results into matched and unmatched groups.
NS_SWIFT_NAME(MatchFacesSimilarityThresholdSplit)
@interface RFSMatchFacesSimilarityThresholdSplit : NSObject

/// The threshold value of the similarity of faces used to make this result.
@property(nonatomic, readwrite, strong, nonnull) NSNumber *similarityThreshold;

/// Matched pairs of faces with similarity is greater or equal than the value of `similarityThreshold`.
@property(readonly, nonatomic, strong, nonnull) NSArray<RFSMatchFacesComparedFacesPair *> *matchedFaces;

/// Unmatched pairs of faces which similarity is less than the value of `similarityThreshold`.
@property(readonly, nonatomic, strong, nonnull) NSArray<RFSMatchFacesComparedFacesPair *> *unmatchedFaces;

RFS_EMPTY_INIT_UNAVAILABLE

- (instancetype)initWithSimilarityThreshold:(NSNumber *)similarityThreshold
                               matchedFaces:(NSArray<RFSMatchFacesComparedFacesPair *> *)matchedFaces
                             unmatchedFaces:(NSArray<RFSMatchFacesComparedFacesPair *> *)unmatchedFaces NS_DESIGNATED_INITIALIZER;

/// Splits `pairs` pairs by given `similarityThreshold`.
/// If the similarity of faces is greater or equal than the threshold, faces will be stored to the `matchedFaces` array, otherwise to the `unmatchedFaces` one.
///
/// @param pairs The input array of compared faces to split.
/// @param similarityThreshold The threshold value of the similarity of faces.
+ (RFSMatchFacesSimilarityThresholdSplit *)splitPairs:(NSArray<RFSMatchFacesComparedFacesPair *> *)pairs
                                bySimilarityThreshold:(NSNumber *)similarityThreshold;

@end

NS_ASSUME_NONNULL_END
