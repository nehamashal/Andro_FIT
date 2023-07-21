//
//  RFSMatchFacesDetection+Internal.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 23/11/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <FaceSDK/RFSMatchFacesDetection.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFSMatchFacesDetection (Private)

- (instancetype)initWithImageIndex:(nonnull NSNumber *)imageIndex
                             image:(nonnull RFSMatchFacesImage *)image
                             faces:(nonnull NSArray<RFSMatchFacesDetectionFace *> *)faces
                             error:(nullable NSError *)error;

@end

NS_ASSUME_NONNULL_END
