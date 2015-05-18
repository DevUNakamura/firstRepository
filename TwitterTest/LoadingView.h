//
//  LoadingView.h
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/18.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

/** 親View */
@property(nonatomic, weak) IBOutlet UIView *view;
/** インジケータView */
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingIndicatorView;

+ (LoadingView*)initWithShow:(UIView*)parentView;

- (void)showLoadingView:(UIView *)parentView;

- (void)hideLoadingView;

typedef void (^hideAnimationEndCallBack)();
@property(nonatomic, strong) hideAnimationEndCallBack hideAnimationEndCallBack;

@end
