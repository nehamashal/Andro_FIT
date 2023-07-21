//
//  RFSPassthroughView.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 4/26/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// The view that will only handle subview's touch events. Other events are passed through.
NS_SWIFT_NAME(PassthroughView)
@interface RFSPassthroughView : UIView

@end

NS_ASSUME_NONNULL_END
