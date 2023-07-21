//
//  RFSPersonImage.h
//  FaceSDK
//
//  Created by Serge Rylko on 5.04.23.
//  Copyright © 2023 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>
#import <FaceSDK/RFSDBBaseItem.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PersonDatabase.PersonImage)
/// A PersonData object that represents Image linked with a Person.
@interface RFSPersonImage : RFSDBBaseItem

/// Image s3 path.
@property (nonatomic, strong, readonly) NSString *path;

/// Full URL for Image.
@property (nonatomic, strong, readonly) NSURL *url;

/// The original media type of the uploaded image.
/// PersonDatabase applies default content-type if it isn't specified during upload.
@property (nonatomic, strong, readonly) NSString *contentType;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
