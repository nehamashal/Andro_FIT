//
//  RFSMatchFacesRequest.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 5/19/19.
//  Copyright © 2019 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSImage;
@class RFSMatchFacesImage;

/// `RFSMatchFacesRequest` compares two or more images with faces on them to find out the similarity of pairs.
///
/// The request is used as a parameter to `-[RFSFaceSDK matchFaces:completion:]`.
NS_SWIFT_NAME(MatchFacesRequest)
@interface RFSMatchFacesRequest : NSObject

/// Defines tag that can be used in match faces processing. Defaults to `nil`.
@property(nonatomic, readwrite, strong, nullable) NSString *tag;

/// Defines whether the response detections should contain `thumbnailImage`.
/// @see `RFSMatchFacesDetectionFace` for `thumbnailImage` property.
/// Defaults to `false`
@property(nonatomic, readwrite, assign) BOOL thumbnails;

/// Images with faces to match.
@property(nonatomic, readonly, copy, nonnull) NSArray<RFSMatchFacesImage *> *images;

RFS_EMPTY_INIT_UNAVAILABLE

// Initializes a request to match and detect faces on input `images`.
- (instancetype)initWithImages:(nonnull NSArray<RFSMatchFacesImage *> *)images NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
