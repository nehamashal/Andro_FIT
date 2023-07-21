//
//  RFSImageQualityCharacteristic.h
//  FaceSDK
//
//  Created by Serge Rylko on 4.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSImageQualityGroup.h>
#import <FaceSDK/RFSImageQualityCharacteristicName.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSImageQualityRange;
@class UIColor;
@class RFSImageQualityColorCharacteristic;

/// Image Quality parameter to include in `RFSDetectFacesConfiguration` as `customQuality`.
NS_SWIFT_NAME(ImageQualityCharacteristic)
@interface RFSImageQualityCharacteristic: NSObject

/// Image Quality Characteristic Name
@property(nonnull, nonatomic, readonly, strong) RFSImageQualityCharacteristicName name;

/// Image Quality Characteristic Group
@property(nonatomic, readonly, assign) RFSImageQualityGroup qualityGroup;

/// Default range of values where Image Quality Characteristic passes validation.
@property(nullable, nonatomic, readonly, copy) RFSImageQualityRange *recommendedRange;

/// Custom range of values where Image Quality Characteristic passes validation.
/// Use `RFSImageQualityCharacteristic.withCustomRange:` to update the range.
@property(nullable, nonatomic, readonly, copy) RFSImageQualityRange *customRange;

/// Updates `customRange` which is used to precise validation range
- (instancetype)withCustomRange:(nonnull NSArray<NSNumber *> *)range;

/// Updates `customRange` which is used to precise validation value
- (instancetype)withCustomValue:(nonnull NSNumber *)value;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_SWIFT_NAME(ImageQualityGroup.Image)
@interface RFSImageCharacteristics: NSObject

/// The image width, pixels.
/// Doesn't have recommended value.
+ (RFSImageQualityCharacteristic *)imageWidthWithRange:(NSArray<NSNumber *> *)range;

/// The image height, pixels.
/// Doesn't have recommended value.
+ (RFSImageQualityCharacteristic *)imageHeightWithRange:(NSArray<NSNumber *> *)range;

/// The image width to height proportion.
/// Doesn't have recommended value.
+ (RFSImageQualityCharacteristic *)imageWidthToHeightWithRange:(NSArray<NSNumber *> *)range;

/// The image RGB channels number.
/// Doesn't have recommended value.
/// Range value [3, 3] is for RGB images.
+ (RFSImageQualityCharacteristic *)imageChannelsNumberWithValue:(NSNumber *)value;

/// Whether the face in the image is a photo, not a drawing, sculpture, cartoon, etc.
/// If the returned value is out of the recommended range, the image is not a photo.
/// The range is from 0 to 1 where 0 means the image is a photo.
+ (RFSImageQualityCharacteristic *)artFace;

/// The percentage of the area of the image that was "padded" during alignment.
/// The characteristic is needed to determine if the head goes beyond the image.
/// The range is from 0 to 1 where 0 is 0% of the image is "padded".
/// Doesn't have recommended value.
+ (RFSImageQualityCharacteristic *)paddingRatioWithMinValue:(NSNumber *)minValue maxValue:(NSNumber *)maxValue;

/// All Group characteristics with default (recommended) values.
/// Doesn't include characteristics without default values.
+ (NSArray<RFSImageQualityCharacteristic *> *)allRecommended;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_SWIFT_NAME(ImageQualityGroup.HeadSizeAndPosition)
@interface RFSHeadSizeAndPosition: NSObject

/// The position of the "middle point" (the middle of the line connecting the eye centers) relative to the width of the image.
/// The range is from 0 to 1 where range [0.5, 0.5] is for "middle point" strictly in the center .
+ (RFSImageQualityCharacteristic *)faceMidPointHorizontalPosition;

/// The position of the "middle point" (the middle of the line connecting the eye centers) relative to the height of the image.
/// The range is from 0 to 1 where range [0.5, 0.5] is for "middle point" strictly in the center .
+ (RFSImageQualityCharacteristic *)faceMidPointVerticalPosition;

/// The head width to the image width ratio.
/// The range is from 0 to 1.
+ (RFSImageQualityCharacteristic *)headWidthRatio;

/// The head height to the image height ratio.
/// The range is from 0 to 1.
+ (RFSImageQualityCharacteristic *)headHeightRatio;

/// Inter-eye distance — the length of the line connecting the eye centers of the left and right eye, pixels.
+ (RFSImageQualityCharacteristic *)eyesDistance;

/// The yaw of the head, degrees.
/// The range is from -90 to 90. Range value [0, 0] for strictly stright head position.
+ (RFSImageQualityCharacteristic *)yaw;

/// The pitch of the head, degrees.
/// The range is from -90 to 90. Range value [0, 0] for strictly stright head position.
+ (RFSImageQualityCharacteristic *)pitch;

/// The roll of the head, degrees.
/// The range is from -90 to 90. Range value [0, 0] for strictly stright head position.
+ (RFSImageQualityCharacteristic *)roll;

/// All Group characteristics with default (recommended) values.
/// Doesn't include characteristics without default values.
+ (NSArray<RFSImageQualityCharacteristic *> *)allRecommended;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_SWIFT_NAME(ImageQualityGroup.FaceImage)
@interface RFSFaceImageQuality: NSObject

/// The blur level.
/// The range is from 0 to 1 where 0 is the absence of blur effect
+ (RFSImageQualityCharacteristic *)blurLevel;

/// The noise level.
/// The range is from 0 to 1 where 0 is minimal noise level.
+ (RFSImageQualityCharacteristic *)noiseLevel;

/// The true-colour representation of the skin colour.
/// The range is from 0 to 1.
+ (RFSImageQualityCharacteristic *)unnaturalSkinTone;

/// The range of tonal difference between the lightest light and darkest dark of an image, bits.
+ (RFSImageQualityCharacteristic *)faceDynamicRange;

/// All Group characteristics with default (recommended) values.
/// Doesn't include characteristics without default values.
+ (NSArray<RFSImageQualityCharacteristic *> *)allRecommended;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_SWIFT_NAME(ImageQualityGroup.Eyes)
@interface RFSEyesCharacteristics: NSObject

/// Whether the right eye is closed.
/// The range is from 0 to 1 where 1 is the eye is fully closed.
+ (RFSImageQualityCharacteristic *)eyeRightClosed;

/// Whether the left eye is closed.
/// The range is from 0 to 1 where 1 is the eye is fully closed.
+ (RFSImageQualityCharacteristic *)eyeLeftClosed;

/// Whether the right eye is occluded.
/// The range is from 0 to 1 where 1 is the eye is fully occluded.
+ (RFSImageQualityCharacteristic *)eyeRightOccluded;

/// Whether the left eye is occluded.
/// The range is from 0 to 1 where 1 is the eye is fully occluded.
+ (RFSImageQualityCharacteristic *)eyeLeftOccluded;

/// Whether there is the red-eye effect.
/// The range is from 0 to 1 where 0 is the absence of  red-eye effect.
+ (RFSImageQualityCharacteristic *)eyesRed;

/// Whether the right eye is covered with hair.
/// The range is from 0 to 1 where 1 is 100% of the eye is covered by hair.
+ (RFSImageQualityCharacteristic *)eyeRightCoveredWithHair;

/// Whether the left eye is covered with hair.
/// The range is from 0 to 1 where 1 is 100% of the eye is covered by hair.
+ (RFSImageQualityCharacteristic *)eyeLeftCoveredWithHair;

/// Whether the person is not looking directly at the camera.
/// The range is from 0 to 1 where 0 is for absolutely direct look.
+ (RFSImageQualityCharacteristic *)offGaze;

/// All Group characteristics with default (recommended) values.
/// Doesn't include characteristics without default values.
+ (NSArray<RFSImageQualityCharacteristic *> *)allRecommended;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_SWIFT_NAME(ImageQualityGroup.ShadowsAndLightning)
@interface RFSShadowsAndLightning: NSObject

/// Whether the photo is too dark.
/// The range is from 0 to 1.
+ (RFSImageQualityCharacteristic *)tooDark;

/// Whether the photo is overexposed.
/// The range is from 0 to 1.
+ (RFSImageQualityCharacteristic *)tooLight;

/// Whether there is glare on the face.
/// The range is from 0 to 1 where 0 is the absence of glare.
+ (RFSImageQualityCharacteristic *)faceGlare;

/// Whether there are shadows on the face.
/// The range is from 0 to 1 where 0 is the absence of shadows on the face.
+ (RFSImageQualityCharacteristic *)shadowsOnFace;

/// All Group characteristics with default (recommended) values.
/// Doesn't include characteristics without default values.
+ (NSArray<RFSImageQualityCharacteristic *> *)allRecommended;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_SWIFT_NAME(ImageQualityGroup.PoseAndExpression)
@interface RFSPoseAndExpression: NSObject

/// Checks the symmetry of the shoulders.
/// The range is from 0 to 1 where 1 is for absolutely symmetrical shoulders.
+ (RFSImageQualityCharacteristic *)shouldersPose;

/// Checks the presence of any emotional facial expression.
/// The range is from 0 to 1 where 0 is for absolutely non-emotional expression.
+ (RFSImageQualityCharacteristic *)expressionLevel;

/// Whether the mouth is open.
/// The range is from 0 to 1 where 0 is closed mouth.
+ (RFSImageQualityCharacteristic *)mouthOpen;

/// Whether the person smiles.
/// The range is from 0 to 1 where 0 is smile absence.
+ (RFSImageQualityCharacteristic *)smile;

/// All Group characteristics with default (recommended) values.
/// Doesn't include characteristics without default values.
+ (NSArray<RFSImageQualityCharacteristic *> *)allRecommended;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_SWIFT_NAME(ImageQualityGroup.HeadOcclusion)
@interface RFSHeadOcclusion: NSObject

/// Whether the person wears dark glasses.
/// The range is from 0 to 1 where 0 is dark glasses absence.
+(RFSImageQualityCharacteristic *)darkGlasses;

/// Whether there are reflections on glasses.
/// The range is from 0 to 1 where 0 is reflections absence.
/// In the current release, always succeeds. Will be developed in the coming releases.
+(RFSImageQualityCharacteristic *)reflectionOnGlasses;

/// Whether the glasses frames do not obscure eye details and the irises of both eyes are visible.
/// The range is from 0 to 20 where 0 the absence of frames (glasses).
+(RFSImageQualityCharacteristic *)framesTooHeavy;

/// Whether the face is visible and not occluded.
/// The range is from 0 to 1 where 0 is face occlusion absence.
+(RFSImageQualityCharacteristic *)faceOccluded;

/// Whether there is any head coverage other than religious headwear.
/// The range is from 0 to 1.
+(RFSImageQualityCharacteristic *)headCovering;

/// Whether the forehead is covered.
/// The range is from 0 to 1.
+(RFSImageQualityCharacteristic *)foreheadCovering;

/// Whether the makeup is too strong.
/// In the current release, always succeeds. Will be developed in the coming releases.
/// The range is from 0 to 1.
+(RFSImageQualityCharacteristic *)strongMakeup;

/// Whether the person is wearing headphones.
/// /// The range is from 0 to 1 where 0 is headphones absence.
+(RFSImageQualityCharacteristic *)headphones;

/// Whether the person is wearing a medical mask.
/// The range is from 0 to 1 where 0 is medical mask absence.
+(RFSImageQualityCharacteristic *)medicalMask;

/// All Group characteristics with default (recommended) values.
/// Doesn't include characteristics without default values.
+ (NSArray<RFSImageQualityCharacteristic *> *)allRecommended;

@end


NS_SWIFT_NAME(ImageQualityGroup.Background)
@interface RFSQualityBackground: NSObject

/// Checks uniformity of the portrait background.
/// The range is from 0 to 1 where 1 is absolute background uniformity.
+ (RFSImageQualityCharacteristic *)backgroundUniformity;

/// Whether there are shadows on the portrait background.
/// The range is from 0 to 1 where 1 is the absence of shadows on the portrait background.
+ (RFSImageQualityCharacteristic *)shadowsOnBackground;

/// The number of faces on the photo.
/// The range starts from 1.
+ (RFSImageQualityCharacteristic *)otherFaces;

/// Whether the background color matches default background color.
/// Default color is white (RGB(255,255,255) or hex #FFFFFF)
/// The range is from 0 to 1 where 1 is full background color match.
+ (RFSImageQualityColorCharacteristic *)backgroundColorMatch;

/// Whether the background color matches the required color.
/// The range is from 0 to 1 where 1 is full background color match.
+ (RFSImageQualityColorCharacteristic *)backgroundColorMatchWithColor:(UIColor*)color;

/// All Group characteristics with default (recommended) values.
/// Doesn't include characteristics without default values.
+ (NSArray<RFSImageQualityCharacteristic *> *)allRecommended;

RFS_EMPTY_INIT_UNAVAILABLE

@end


NS_ASSUME_NONNULL_END
