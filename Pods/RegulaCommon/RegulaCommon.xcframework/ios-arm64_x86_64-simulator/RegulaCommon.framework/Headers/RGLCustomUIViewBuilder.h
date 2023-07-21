//
//  RGLCustomUIViewBuilder.h
//  RegulaCommon
//
//  Created by Dmitry Evglevsky on 19.05.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RGLCustomUIViewActionDelegate <NSObject>

- (void)onButtonTapped:(UIButton * _Nonnull)button;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RGLCustomUIViewBuilder : NSObject

@property(readwrite, nonatomic, weak, nullable) id<RGLCustomUIViewActionDelegate> delegate;

- (void)rebuildUIForContentView:(UIView *)contentView contentBackView:(UIView *_Nullable)contentBackView
                       withJSON:(NSDictionary *)jsonDictionary;

@end

NS_ASSUME_NONNULL_END
