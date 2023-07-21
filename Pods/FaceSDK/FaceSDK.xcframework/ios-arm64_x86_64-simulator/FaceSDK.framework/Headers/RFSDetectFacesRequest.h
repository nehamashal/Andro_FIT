//
//  RFSDetectFacesRequest.h
//  FaceSDK
//
//  Created by Serge Rylko on 29.07.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSDetectFacesConfiguration;

/// Detect Faces Request.
/// Could be created by predefined scenarios (e.g: `qualityICAORequest`, `cropAllFacesRequest` etc. )
/// or by using custom `RFSDetectFacesConfiguration`.
NS_SWIFT_NAME(DetectFacesRequest)
@interface RFSDetectFacesRequest: NSObject

/// Defines tag that can be used in detect faces processing. Defaults to `nil`.
@property(nullable, nonatomic, strong) NSString *tag;

/// Base64 image to process.
@property(nonnull, nonatomic, readonly, strong) UIImage *image;

/// Current Face Detection scenario.
/// `nil` for custom `RFSDetectFacesRequest`
@property(nullable, nonatomic, readonly) NSString *scenario;

/// Custom Request configuration to specify  image, quality, attributes parameters.
/// `nil` for request with predefined scenario (like ICAO, VisaSchengen etc.).
@property(nullable, nonatomic, copy) RFSDetectFacesConfiguration *configuration;

/// Creates a request to check all the available quality characteristics.
+ (instancetype)qualityFullRequestForImage:(nonnull UIImage *)image;

/// Creates a request to check the quality characteristics based on the ICAO standard.
+ (instancetype)qualityICAORequestForImage:(nonnull UIImage *)image;

/// Creates a request to check the quality characteristics based on the Schengen visa standard.
+ (instancetype)qualityVisaSchengenRequestForImage:(nonnull UIImage *)image;

/// Creates a request to check the quality characteristics based on the USA visa standard.
+ (instancetype)qualityVisaUSARequestForImage:(nonnull UIImage *)image;

/// Creates a request for a cropped portrait of the person whose face is the most central.
+ (instancetype)cropCentralFaceRequestForImage:(nonnull UIImage *)image;

/// Creates a request for cropped portraits of all the people in the image.
+ (instancetype)cropAllFacesRequestForImage:(nonnull UIImage *)image;

/// Creates a request for a cropped portrait of the person whose face is the most central in the image in the original size.
+ (instancetype)thumbnailRequestForImage:(nonnull UIImage *)image;

/// Creates a request for all available attribute results.
+ (instancetype)allAttributesRequestForImage:(nonnull UIImage *)image;


RFS_EMPTY_INIT_UNAVAILABLE

/// Creates a request with custom configuration (custom quality, output image params, attributes etc.).
- (instancetype)initWithImage:(nonnull UIImage *)image
                configuration:(nonnull RFSDetectFacesConfiguration *)configuration;

@end

NS_ASSUME_NONNULL_END
