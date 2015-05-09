//
//  MttImageBrowserView.h
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/9.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat MttImageBrowserViewToolbarHeight;
extern const CGFloat MttImageBrowserViewThumbnailHeight;
extern const CGFloat MttImageBrowserViewThumbnailLeftMargin;

@class MttImageBrowserToolbarView;
@class MttImageBrowserThumbnailsView;

@interface MttImageBrowserView : UIView
@property (nonatomic, strong) MttImageBrowserThumbnailsView *thumbnailsView;
@property (nonatomic, strong) MttImageBrowserToolbarView *toolbarView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL isMaskHidden;

- (void)setMaskHidden:(BOOL)hidden animated:(BOOL)animated;

@end
