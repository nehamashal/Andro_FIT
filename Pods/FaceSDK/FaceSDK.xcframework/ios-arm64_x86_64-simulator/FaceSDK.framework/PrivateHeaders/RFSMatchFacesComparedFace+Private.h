//
//  RFSMatchFacesComparedFace+Private.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 6/1/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <FaceSDK/RFSMatchFacesComparedFace.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSMatchFacesDetectionFace;
@class RFSMatchFacesImage;

@interface RFSMatchFacesComparedFace (Private)

- (instancetype)initWithImageIndex:(nonnull NSNumber *)imageIndex
                             image:(nonnull RFSMatchFacesImage *)image
                         faceIndex:(nullable NSNumber *)faceIndex
                              face:(nullable RFSMatchFacesDetectionFace *)face;

@end

NS_ASSUME_NONNULL_END
