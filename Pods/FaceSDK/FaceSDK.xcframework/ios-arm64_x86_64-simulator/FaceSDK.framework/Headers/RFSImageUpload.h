//
//  RFSImageUpload.h
//  FaceSDK
//
//  Created by Serge Rylko on 14.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PersonDatabase.ImageUpload)
/// An object that represents uploaded image with its settings.
@interface RFSImageUpload : NSObject

/// Data object that contains an image.
@property (nonatomic, strong, readonly) NSData *imageData;

/// Content type of Image to upload.
@property (nullable, nonatomic, strong) NSString *contentType;

/// Create new upload object.
/// - Parameter imageData: Data object that contains an image.
- (instancetype)initWithImageData:(NSData *)imageData;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
