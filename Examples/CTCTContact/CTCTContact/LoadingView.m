//
//  LoadingView.m
//  Inzonata
//
//  Created by Vasile Gales on 2/18/13.
//  Copyright (c) 2013 OSF Global. All rights reserved.
//


#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>

@interface LoadingView()

@property (nonatomic, strong) UIView *hoverView;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end

@implementation LoadingView

@synthesize hoverView = _hoverView;
@synthesize loadingView = _loadingView;
@synthesize spinner = _spinner;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *hover = [[UIView alloc] initWithFrame:frame];
        hover.backgroundColor = [UIColor clearColor];
        
        UIView *loading = [[UIView alloc] initWithFrame:CGRectMake(120, 170, 70, 70)];
        loading.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
        loading.layer.cornerRadius = 5.0;
        
        UIActivityIndicatorView *spin = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spin.center = CGPointMake(loading.frame.size.width/2, loading.frame.size.height/2);
        
        [loading addSubview:spin];
        
        loading.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        _spinner = spin;
                
        [hover addSubview:loading];
        _loadingView = loading;
        _hoverView = hover;
        
        [self addSubview:self.hoverView];
    }
    return self;
}

- (void)showLoadingInView:(UIView*)superView
{
    self.spinner.hidden = NO;
    self.alpha = 0.0;
    
    [self.spinner startAnimating];
    [superView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
    
}

- (void)hideLoading
{
    [UIView animateWithDuration:0.2 animations:^{

    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.spinner stopAnimating];
        self.spinner.hidden = YES;
        [self removeFromSuperview];
    }];
}


@end

