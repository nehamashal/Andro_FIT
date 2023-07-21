//
//  RFSURLRequestInterceptingDelegate.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 6/2/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Delegate for intercepting URL requests.
NS_SWIFT_NAME(URLRequestInterceptingDelegate)
@protocol RFSURLRequestInterceptingDelegate <NSObject>

@required

/// Prepares `URLRequest` before sending it to the service.
- (NSURLRequest * _Nullable)interceptorPrepareRequest:(NSURLRequest * _Nonnull)request;

@end

NS_ASSUME_NONNULL_END
