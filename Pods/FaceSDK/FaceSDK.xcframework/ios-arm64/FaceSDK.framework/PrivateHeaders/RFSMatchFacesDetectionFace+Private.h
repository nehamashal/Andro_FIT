//
//  RFSMatchFacesDetectionFace+Private.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 23/11/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <FaceSDK/RFSMatchFacesDetectionFace.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFSMatchFacesDetectionFace (Private)

- (instancetype)initWithFaceIndex:(nonnull NSNumber *)faceIndex
                        landmarks:(nonnull NSArray<RFSPoint *> *)landmarks
                         faceRect:(CGRect)faceRect
                    rotationAngle:(nullable NSNumber *)rotationAngle
                   thumbnailImage:(nullable UIImage *)thumbnailImage;

@end

NS_ASSUME_NONNULL_END
