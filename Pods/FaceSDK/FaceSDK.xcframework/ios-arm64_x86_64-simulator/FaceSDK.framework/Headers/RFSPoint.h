//
//  RFSPoint.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 23/11/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

/// Point class represents a two number X, Y value.
NS_SWIFT_NAME(Point)
@interface RFSPoint : NSObject

@property(nonatomic, readonly, assign) CGFloat x;
@property(nonatomic, readonly, assign) CGFloat y;

@property(nonatomic, readonly, assign) CGPoint cgPoint;

RFS_EMPTY_INIT_UNAVAILABLE

- (instancetype)initWithX:(CGFloat)x y:(CGFloat )y NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithNumberX:(nonnull NSNumber *)x numberY:(nonnull NSNumber *)y;

@end

NS_ASSUME_NONNULL_END
