//
//  RFSOutputImageParams.h
//  FaceSDK
//
//  Created by Deposhe on 16.08.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class UIColor;
@class RFSOutputImageCrop;

/// Set of parameter for image processing.
NS_SWIFT_NAME(OutputImageParams)
@interface RFSOutputImageParams : NSObject

/// If set, the background color is replaced.
/// The silhouette of a person is cut out and the background is filled with this color.
@property(nullable, nonatomic, strong) UIColor *backgroundColor;

/// If set, the Base64 of an aligned and cropped portrait is returned in the crop field.
/// Alignment is performed according to type.
/// If a head on the original image is tilted, for the returned portrait it is aligned in a straight vertical line.
///
/// If there are more than one face in the photo, all the faces will be detected and processed, and separate portraits for each face will be returned.
/// So, if there were five people in the photo, you'll get five processed portraits.
@property(nullable, nonatomic, strong) RFSOutputImageCrop *crop;

@end

NS_ASSUME_NONNULL_END
