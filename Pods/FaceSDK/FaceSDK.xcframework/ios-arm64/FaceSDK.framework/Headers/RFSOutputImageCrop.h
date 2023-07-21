//
//  RFSOutputImageCrop.h
//  FaceSDK
//
//  Created by Serge Rylko on 16.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

/// The AspectRatio according to which alignment is performed
typedef NS_ENUM(NSUInteger, RFSOutputImageCropAspectRatio) {
    RFSOutputImageCropAspectRatio3x4,
    RFSOutputImageCropAspectRatio4x5,
    RFSOutputImageCropAspectRatio2x3,
    RFSOutputImageCropAspectRatio1x1,
    RFSOutputImageCropAspectRatio7x9,
} NS_SWIFT_NAME(OutputImageCrop.AspectRatio);

@class UIColor;

/// Crop settings for `RFSOutputImageParams`.
NS_SWIFT_NAME(OutputImageCrop)
@interface RFSOutputImageCrop: NSObject

/// The aspect ratio according to which alignment is performed
@property(nonatomic, readonly, assign) RFSOutputImageCropAspectRatio type;

/// The resize value to process.
/// If the value doesn't match AspectRatio `type` proportion or minimum size, an adjustment is applied.
/// Use `RFSOutputImageCropAspectRatio.adjustPreferredSize:forType:` to check you size matches AspectRatio `type` proportions and minimum size.
@property(nonatomic, readonly, assign) CGSize size;

/// When an image is aligned by `type`, its original size may be insufficient, and in this case it needs to be supplemented, "padded".
/// padColor sets the value for the color that will be used for such a supplement.
@property(nullable, nonatomic, readonly) UIColor *padColor;

/// If set, the coordinates of the rectangle with the face in the original image prepared for the face crop are returned in the `RFSDetectFaceResult.originalRect` field.
/// Default is NO
@property(nonatomic, readonly) BOOL returnOriginalRect;

RFS_EMPTY_INIT_UNAVAILABLE

- (instancetype)initWithType:(RFSOutputImageCropAspectRatio)type
                        size:(CGSize)size
                    padColor:(nullable UIColor *)padcolor
          returnOriginalRect:(BOOL)returnOriginalRect;

- (instancetype)initWithType:(RFSOutputImageCropAspectRatio)type;

- (instancetype)initWithType:(RFSOutputImageCropAspectRatio)type
                        size:(CGSize)size;

/// Calculates adjusted size for specified AspectRatio `type`.
+(CGSize)adjustPreferredSize:(CGSize)size
                     forType:(RFSOutputImageCropAspectRatio)type;

@end

NS_ASSUME_NONNULL_END
