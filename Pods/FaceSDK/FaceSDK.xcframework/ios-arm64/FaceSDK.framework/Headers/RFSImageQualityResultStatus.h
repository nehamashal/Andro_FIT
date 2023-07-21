//
//  RFSImageQualityStatus.h
//  FaceSDK
//
//  Created by Serge Rylko on 8.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

/// The assessment status of Image Quality Characteristic
typedef NS_ENUM(NSInteger,RFSImageQualityResultStatus) {
  /// The characteristic is defined but is out of the range of set values.
  RFSImageQualityResultStatusFalse = 0,
  /// The characteristic is defined and fits the range of set values.
  RFSImageQualityResultStatusTrue = 1,
  /// The characteristic is not defined.
  RFSImageQualityResultStatusUndetermined = 2,
} NS_SWIFT_NAME(ImageQualityResult.Status);
