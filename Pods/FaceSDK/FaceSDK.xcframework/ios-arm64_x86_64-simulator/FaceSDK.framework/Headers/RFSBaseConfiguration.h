//
//  RFSBaseConfiguration.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 4/16/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSOverriding.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class RFSBaseConfigurationBuilder;

/// Base class for creating immutable configuration objects.
NS_SWIFT_NAME(BaseConfiguration)
@interface RFSBaseConfiguration<T : __kindof RFSBaseConfigurationBuilder *> : NSObject

RFS_EMPTY_INIT_UNAVAILABLE

- (instancetype)initWithBuilder:(T)builder NS_DESIGNATED_INITIALIZER;

+ (instancetype)defaultConfiguration;
+ (instancetype)configurationWithBuilder:(nullable NS_NOESCAPE void (^)(T))builderBlock;

@end

/// Base class for creating immutable configuration objects. This is a mutable part that is configured in the `builderBlock` of the `RFSBaseConfiguration`.
NS_SWIFT_NAME(BaseConfigurationBuilder)
@interface RFSBaseConfigurationBuilder : NSObject

RFS_EMPTY_INIT_UNAVAILABLE

/// Registers new class to be used for creating an instanse instead of a base class.
///
/// @param newClass The class to be used in place of the instance of `baseClass`. This class must be a subclass of a `baseClass`.
/// @param baseClass The original class to be overriden.
- (void)registerClass:(Class<RFSOverriding>)newClass forBaseClass:(Class<RFSOverriding>)baseClass;

@end

NS_ASSUME_NONNULL_END
