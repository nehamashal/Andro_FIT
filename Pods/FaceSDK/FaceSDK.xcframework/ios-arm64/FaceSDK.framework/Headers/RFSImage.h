//
//  RFSImage.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 5/19/19.
//  Copyright © 2019 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSImageType.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

/// The Image class wraps regular `UIImage` and provides more information to the input and output data.
NS_SWIFT_NAME(Image)
@interface RFSImage : NSObject

/// Unique identifier for Image object.
/// UUID with RFC 4122 version 4 random by such as "E621E1F8-C36C-495A-93FC-0C247A3E6E5F".
@property(nonatomic, readonly, nonnull) NSString *identifier;

/// The underlying image.
@property(nonatomic, readonly, strong, nonnull) UIImage *image;

/// The image type.
@property(nonatomic, readonly, assign) RFSImageType imageType;

RFS_EMPTY_INIT_UNAVAILABLE

- (instancetype)initWithImage:(nonnull UIImage *)image type:(RFSImageType)imageType NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
