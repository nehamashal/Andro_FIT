//
//  RFSImageType.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 26/11/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

/// The image type of `RFSImage` influences matching results and provides the information about the source of the image.
typedef NS_ENUM(NSInteger, RFSImageType) {
    /// The image contains a printed portrait of a person.
    RFSImageTypePrinted = 1,
    /// The image contains a portrait of a person and is taken from the RFID chip.
    RFSImageTypeRFID = 2,
    /// The image is taken from the camera.
    RFSImageTypeLive = 3,
    /// The image contains a document with a portrait of a person.
    RFSImageTypeDocumentWithLive = 4,
    /// The image from an unknown source.
    RFSImageTypeExternal = 5,
    /// The image is a ghost portrait.
    RFSImageTypeGhostPortrait = 6,
} NS_SWIFT_NAME(ImageType);
