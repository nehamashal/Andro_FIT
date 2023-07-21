//
//  RFSMatchFacesImage.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 26/11/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>
#import <FaceSDK/RFSImageType.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;
@class RFSImage;

/// This class represents the input image and its attributes for `RFSMatchFacesRequest`.
NS_SWIFT_NAME(MatchFacesImage)
@interface RFSMatchFacesImage : NSObject

/// Unique identifier for Image object.
/// UUID with RFC 4122 version 4 random by such as "E621E1F8-C36C-495A-93FC-0C247A3E6E5F".
@property(nonatomic, readonly, nonnull) NSString *identifier;

/// The underlying image.
@property(nonatomic, readonly, strong, nonnull) UIImage *image;

/// The image type.
/// The imageType influences matching results, therefore this field is required.
@property(nonatomic, readonly, assign) RFSImageType imageType;

/// Defines whether the comparison and detection should apply for all faces found on the image. Defaults to `false`.
/// When set to `false`, only the most centered faces are compared and detected.
/// Otherwise, all the faces are compared and detected.
@property(nonatomic, readonly, assign) BOOL detectAll;

RFS_EMPTY_INIT_UNAVAILABLE

- (instancetype)initWithImage:(UIImage *)image imageType:(RFSImageType)imageType detectAll:(BOOL)detectAll;
- (instancetype)initWithImage:(UIImage *)image imageType:(RFSImageType)imageType;

- (instancetype)initWithRFSImage:(RFSImage *)image detectAll:(BOOL)detectAll;
- (instancetype)initWithRFSImage:(RFSImage *)image;

@end

NS_ASSUME_NONNULL_END
