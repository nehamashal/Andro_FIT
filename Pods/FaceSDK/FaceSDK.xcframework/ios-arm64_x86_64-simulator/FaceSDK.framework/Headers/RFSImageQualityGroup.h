//
//  RFSImageQualityGroup.h
//  FaceSDK
//
//  Created by Serge Rylko on 2.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Image Quality charactestic group
typedef NS_ENUM(NSInteger,RFSImageQualityGroup) {
  /// The Image characteristics group includes width, height, width to height proportions, the image RGB channels number, and padding ratio.
  RFSImageQualityGroupImageСharacteristics = 1,
  /// The Head size and position group includes the position of the "middle point" relative to the width and height of the image, the head width to the image width and height ratio, inter-eye distance, yaw, pitch, roll.
  RFSImageQualityGroupHeadSizeAndPosition = 2,
  /// The Face image quality group includes blur and noise levels, unnatural skin tone, and face dynamic range checks.
  RFSImageQualityGroupFaceQuality = 3,
  /// The Eyes characteristics group checks eyes closure, occlusion, hair coverage, red eye effect, and whether a person is looking directly at the camera.
  RFSImageQualityGroupEyesCharacteristics = 4,
  /// The Shadows and lightning characteristics group checks whether a photo is too dark or overexposed, if there are glares or shadows on the face.
  RFSImageQualityGroupShadowsAndLightning = 5,
  /// The Pose and expression characteristics group checks the shoulders pose, face expression, whether there is an open mouth or smile.
  RFSImageQualityGroupPoseAndExpression = 6,
  /// The Head occlusion group includes checks of glasses, face occlusion, and head coverage.
  RFSImageQualityGroupHeadOcclusion = 7,
  /// The Background characteristics group checks the background uniformity, shadows on background, and other faces' presence on the picture.
  RFSImageQualityGroupBackground = 8,
} NS_SWIFT_NAME(ImageQualityGroup);
