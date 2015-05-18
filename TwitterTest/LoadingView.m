//
//  LoadingView.m
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/18.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UINib *nib = [UINib nibWithNibName:@"LoadingView" bundle:[NSBundle mainBundle]];
        NSArray *array = [nib instantiateWithOwner:self options:nil];
        [self addSubview:[array objectAtIndex:0]];
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        self.view.frame = self.frame;
    }
    return self;
}

- (void)awakeFromNib
{
    UINib *nib = [UINib nibWithNibName:@"LoadingView" bundle:[NSBundle mainBundle]];
    NSArray *array = [nib instantiateWithOwner:self options:nil];
    [self addSubview:[array objectAtIndex:0]];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    self.view.frame = self.frame;
}

+ (LoadingView*)initWithShow:(UIView*)parentView {
    LoadingView *loadingView = [[LoadingView alloc] init];
    [loadingView showLoadingView:parentView];
    return loadingView;
}


- (void)showLoadingView:(UIView *)parentView
{
    [parentView addSubview:self];
    self.alpha = 0.f;
    self.hidden = NO;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                     }];
}



/*
 アラートビューの非表示
 */
- (void)hideLoadingView
{
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.alpha = 0.f;
                     }
                     completion:^(BOOL finished) {
                         if (self.hideAnimationEndCallBack) {
                             self.hideAnimationEndCallBack();
                         }
                         self.hidden = YES;
                         [self removeFromSuperview];
                         
                         
                     }];
}


@end
