//
//  RFSMatchFacesComparedFacesPair.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 5/19/19.
//  Copyright © 2019 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

@class RFSMatchFacesComparedFace;

NS_ASSUME_NONNULL_BEGIN

/// `RFSMatchFacesComparedFacesPair` represents a result of the `RFSMatchFacesRequest` attempt to compare input images.
NS_SWIFT_NAME(MatchFacesComparedFacesPair)
@interface RFSMatchFacesComparedFacesPair : NSObject

/// The first face in the comparison pair.
@property(readonly, nonatomic, strong, nonnull) RFSMatchFacesComparedFace *first;

/// The second face in the comparison pair.
@property(readonly, nonatomic, strong, nonnull) RFSMatchFacesComparedFace *second;

/// The raw value returned by the service without applying any thresholds or comparison rules.
/// The value shows the degree of similarity of compared faces, the lower - the more similar, and vice versa less similar.
/// The `score` is used in conjunction with the input image `imageType` to evaluate `similarity`.
/// @see `similarity` for checking how compared faces are similar to each other.
@property(readonly, nonatomic, strong, nullable) NSNumber *score;

/// Similarity of the faces pair. Floating point value from 0 to 1.
@property(readonly, nonatomic, strong, nullable) NSNumber *similarity;

/// The error describes a failed pair comparison and contains `RFSMatchFacesErrorCode` codes.
/// This error belongs to the `RFSMatchFacesErrorDomain`
@property(readonly, nonatomic, strong, nullable) NSError *error;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
