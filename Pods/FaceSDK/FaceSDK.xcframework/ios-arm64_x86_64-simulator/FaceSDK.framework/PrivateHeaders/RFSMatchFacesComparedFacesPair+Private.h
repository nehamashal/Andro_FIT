//
//  RFSMatchFacesComparedFacesPair+Private.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 6/1/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <FaceSDK/RFSMatchFacesComparedFacesPair.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSMatchFacesComparedFace;

@interface RFSMatchFacesComparedFacesPair (Private)

- (instancetype)initWithFirst:(nonnull RFSMatchFacesComparedFace *)first
                       second:(nonnull RFSMatchFacesComparedFace *)second
                        score:(nullable NSNumber *)score
                   similarity:(nullable NSNumber *)similarity
                        error:(nullable NSError *)error;

@end

NS_ASSUME_NONNULL_END
