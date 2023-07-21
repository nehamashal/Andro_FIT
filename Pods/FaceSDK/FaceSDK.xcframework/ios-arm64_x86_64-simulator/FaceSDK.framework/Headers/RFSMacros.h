//
//  RFSMacros.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 11/19/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#define RFS_DEPRECATED(_version, _msg) __attribute__((deprecated("Deprecated in FaceSDK " #_version ". " _msg)))

#define RFS_UNAVAILABLE(_message) __attribute__((unavailable(_message)))

#ifndef RFS_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE
#define RFS_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE RFS_UNAVAILABLE("Not the designated initializer")
#endif

#define RFS_EMPTY_INIT_UNAVAILABLE \
    - (instancetype)init RFS_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE; \
    + (instancetype)new RFS_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE;
