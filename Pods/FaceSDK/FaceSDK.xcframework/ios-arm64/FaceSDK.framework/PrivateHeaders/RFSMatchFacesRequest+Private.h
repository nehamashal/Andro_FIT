//
//  RFSMatchFacesRequest+Private.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 24/11/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <FaceSDK/RFSMatchFacesRequest.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFSMatchFacesRequest (Private)

/// Custom metadata. It can include a collection of information like age, male, country and etc. Defaults to `nil`.
@property(nonatomic, readwrite, strong, nullable) NSDictionary *metadata;

@end

NS_ASSUME_NONNULL_END
