//
//  RFSHintView.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 4/27/21.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RFSHintViewState) {
    RFSHintViewStateFront,
    RFSHintViewStateRear,
} NS_SWIFT_NAME(HintViewState);

NS_SWIFT_NAME(HintView)
@interface RFSHintView : UIView

@property(readwrite, nonatomic, assign) RFSHintViewState state;
@property(readwrite, nonatomic, strong, nullable) NSString *text;

#pragma mark - Styling

@property(readwrite, nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

- (void)setTextColor:(nullable UIColor *)color forState:(RFSHintViewState)state UI_APPEARANCE_SELECTOR;
- (nullable UIColor *)textColorForState:(RFSHintViewState)state UI_APPEARANCE_SELECTOR;

- (void)setBackgroundColor:(nullable UIColor *)color forState:(RFSHintViewState)state UI_APPEARANCE_SELECTOR;
- (nullable UIColor *)backgroundColorForState:(RFSHintViewState)state UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
