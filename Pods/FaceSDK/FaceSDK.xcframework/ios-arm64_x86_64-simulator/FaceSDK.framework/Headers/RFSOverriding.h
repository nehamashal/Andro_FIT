//
//  RFSOverriding.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 4/27/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Marks the class to be overridable through configuration builder. See more at `-[RFSBaseConfigurationBuilder registerClass:forBaseClass:]`.
NS_SWIFT_NAME(Overriding)
@protocol RFSOverriding <NSObject>
@end

NS_ASSUME_NONNULL_END
