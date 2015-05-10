//
//  MttImageBrowserView.h
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/9.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MttImageBrowserViewDelegate.h"

extern const CGFloat MttImageBrowserViewToolbarHeight;
extern const CGFloat MttImageBrowserViewThumbnailHeight;
extern const CGFloat MttImageBrowserViewThumbnailLeftMargin;

@class MttImageBrowserToolbarView;
@class MttImageBrowserThumbnailsView;

@interface MttImageBrowserView : UIView<MttImageBrowserControl>
@property (nonatomic, strong) MttImageBrowserThumbnailsView *thumbnailsView;
@property (nonatomic, strong) MttImageBrowserToolbarView *toolbarView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, weak) id<MttImageBrowserViewDataSource> dataSource;
@property (nonatomic, weak) id<MttImageBrowserControl> control;

@property (nonatomic, assign) BOOL isMaskHidden;
@property (nonatomic, assign) NSUInteger indexOfCurrentItem;

- (void)reloadData;
- (void)reloadDataAtIndex:(NSUInteger)index;
- (void)setMaskHidden:(BOOL)hidden animated:(BOOL)animated;

@end
