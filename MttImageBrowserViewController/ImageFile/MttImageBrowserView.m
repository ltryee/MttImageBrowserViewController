//
//  MttImageBrowserView.m
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/9.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#import "MttImageBrowserView.h"
#import "MttImageBrowserToolbarView.h"
#import "MttImageBrowserThumbnailsView.h"

@interface MttImageBrowserView()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@end

@implementation MttImageBrowserView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        self.isMaskHidden = NO;
        
        [self setupScrollView];
        [self setupToolbarView];
        [self setupThumbnailsView];
        
        [self setupGestureRecognizers];
    }
    return self;
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor purpleColor];
    self.scrollView.delegate = self;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.scrollView];
}

- (void)setupToolbarView {
    self.toolbarView = [[MttImageBrowserToolbarView alloc]
                        initWithFrame:CGRectMake(0,
                                                 0,
                                                 CGRectGetWidth(self.bounds),
                                                 80)];
    self.toolbarView.backgroundColor = [UIColor blackColor];
    self.toolbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:self.toolbarView];
}

- (void)setupThumbnailsView {
    const CGFloat horizentalMargin = 100;
    self.thumbnailsView = [[MttImageBrowserThumbnailsView alloc]
                           initWithFrame:CGRectMake(horizentalMargin,
                                                    CGRectGetHeight(self.bounds) - 80,
                                                    CGRectGetWidth(self.bounds) - 2 * horizentalMargin,
                                                    80)];
    self.thumbnailsView.backgroundColor = [UIColor redColor];
    self.thumbnailsView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:self.thumbnailsView];
}

- (void)setMaskHidden:(BOOL)hidden animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.toolbarView.alpha = hidden ? 0 : 1;
                             self.thumbnailsView.alpha = hidden ? 0 : 1;
                         }];
    }
    else {
        self.toolbarView.alpha = hidden ? 0 : 1;
        self.thumbnailsView.alpha = hidden ? 0 : 1;
    }
    
    self.isMaskHidden = hidden;
}

#pragma mark - gestures
- (void)setupGestureRecognizers {
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    singleTapGestureRecognizer.delegate = self;
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTapGestureRecognizer];
    
    UITapGestureRecognizer * doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTap:)];
    doubleTapGestureRecognizer.delegate = self;
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTapGestureRecognizer];
}

- (void)onSingleTap:(UITapGestureRecognizer *)gestureRecognizer {
    [self setMaskHidden:!self.isMaskHidden animated:YES];
}

- (void)onDoubleTap:(UITapGestureRecognizer *)gestureRecognizer {
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[MttImageBrowserThumbnailsView class]] ||
        [touch.view isKindOfClass:[MttImageBrowserToolbarView class]]) {
        
        return NO;
    }
    return YES;
}

#pragma mark - UIScrollViewDelegate
@end
