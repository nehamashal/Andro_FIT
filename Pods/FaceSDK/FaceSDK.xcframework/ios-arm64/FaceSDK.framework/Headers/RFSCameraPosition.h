//
//  RFSCameraPosition.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 4/16/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Physical position of camera's hardware on the system.
typedef NS_CLOSED_ENUM(NSInteger, RFSCameraPosition) {
    /// The camera position corresponds to the front camera.
    RFSCameraPositionFront,
    /// The camera position corresponds to the back camera.
    RFSCameraPositionBack,
} NS_SWIFT_NAME(CameraPosition);
