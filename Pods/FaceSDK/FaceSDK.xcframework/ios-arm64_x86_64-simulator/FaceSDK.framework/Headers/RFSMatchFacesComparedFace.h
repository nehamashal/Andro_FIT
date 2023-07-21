//
//  RFSMatchFacesComparedFace.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 5/19/19.
//  Copyright © 2019 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSMatchFacesDetectionFace;
@class RFSMatchFacesImage;

/// `RFSMatchFacesComparedFace` represents a reference information of the compared face.
NS_SWIFT_NAME(MatchFacesComparedFace)
@interface RFSMatchFacesComparedFace : NSObject

/// The index to the input image in the input array provided to the request.
@property(nonatomic, readonly, strong, nonnull) NSNumber *imageIndex;

/// The input image used for comparison operation.
@property(nonatomic, readonly, strong, nonnull) RFSMatchFacesImage *image;

/// The index to the array of `faces` in the `detection` results.
@property(nonatomic, readonly, strong, nullable) NSNumber *faceIndex;

/// The face detection result.
@property(nonatomic, readonly, strong, nullable) RFSMatchFacesDetectionFace *face;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
