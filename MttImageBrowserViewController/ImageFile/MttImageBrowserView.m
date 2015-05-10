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
#import "MttImageBrowserItemView.h"
#import "MttImageBrowserThumbnailsItemView.h"

const CGFloat MttImageBrowserViewToolbarHeight = 80;
const CGFloat MttImageBrowserViewThumbnailHeight = 80;
const CGFloat MttImageBrowserViewThumbnailLeftMargin = 100;

@interface MttImageBrowserView()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableDictionary *items;
@end

@implementation MttImageBrowserView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        self.isMaskHidden = NO;
        self.control = (id<MttImageBrowserControl>)self;
        self.items = [NSMutableDictionary dictionary];
        
//        [self setupScrollView];
//        [self setupToolbarView];
//        [self setupThumbnailsView];
        
        [self setupGestureRecognizers];
    }
    return self;
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor purpleColor];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.scrollView];
}

- (void)setupToolbarView {
    self.toolbarView = [[MttImageBrowserToolbarView alloc]
                        initWithFrame:CGRectMake(0,
                                                 0,
                                                 CGRectGetWidth(self.bounds),
                                                 MttImageBrowserViewToolbarHeight)];
    self.toolbarView.backgroundColor = [UIColor blackColor];
    self.toolbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.toolbarView.control = self;
    [self addSubview:self.toolbarView];
}

- (void)setupThumbnailsView {
    self.thumbnailsView = [[MttImageBrowserThumbnailsView alloc]
                           initWithFrame:CGRectMake(MttImageBrowserViewThumbnailLeftMargin,
                                                    CGRectGetHeight(self.bounds) - MttImageBrowserViewThumbnailHeight,
                                                    CGRectGetWidth(self.bounds) - 2 * MttImageBrowserViewThumbnailLeftMargin,
                                                    MttImageBrowserViewThumbnailHeight)];
    self.thumbnailsView.backgroundColor = [UIColor redColor];
    self.thumbnailsView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.thumbnailsView.control = self;
    [self addSubview:self.thumbnailsView];
}

#pragma mark - public methods

- (void)reloadDataAtIndex:(NSUInteger)index {
    // clear data
    [self.items removeAllObjects];
    
    // remove subviews
    if (self.toolbarView) {
        [self.toolbarView removeFromSuperview];
        self.toolbarView = nil;
    }
    if (self.thumbnailsView) {
        [self.thumbnailsView removeFromSuperview];
        self.thumbnailsView = nil;
    }
    if (self.scrollView) {
        [self.scrollView removeFromSuperview];
        self.scrollView = nil;
    }
    
    // initialize subviews
    [self setupScrollView];
    if ([self.dataSource respondsToSelector:@selector(toolbarViewForImageBrowserView:)]) {
        self.toolbarView = [self.dataSource toolbarViewForImageBrowserView:self];
        [self addSubview:self.toolbarView];
    }
    else {
        [self setupToolbarView];
    }
    if ([self.dataSource respondsToSelector:@selector(thumbnailsViewForImageBrowserView:)]) {
        self.thumbnailsView = [self.dataSource thumbnailsViewForImageBrowserView:self];
        [self addSubview:self.thumbnailsView];
    }
    else {
        [self setupThumbnailsView];
    }
    
    // set subviews' data
    NSUInteger itemCount = [self.dataSource numberOfItemsInImageBrowserView:self];
    self.indexOfCurrentItem = MAX(0, MIN(itemCount - 1, index));
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * itemCount, CGRectGetHeight(self.bounds));
    
    if ([self.dataSource respondsToSelector:@selector(imageBrowserView:titleForToolbarAtIndex:)]) {
        self.toolbarView.title = [self.dataSource imageBrowserView:self
                                            titleForToolbarAtIndex:self.indexOfCurrentItem];
    }
    
    if ([self.dataSource respondsToSelector:@selector(imageBrowserView:thumbnailItemAtIndex:)]) {
        for (NSUInteger i = 0; i < itemCount; ++i) {
//            MttImageBrowserThumbnailsItemView * thumbnailItemView = [self.dataSource imageBrowserView:self thumbnailItemAtIndex:i];
        }
    }
    
    if ([self.dataSource respondsToSelector:@selector(imageBrowserView:itemAtIndex:)]) {
        MttImageBrowserItemView * itemView = [self.dataSource imageBrowserView:self itemAtIndex:self.indexOfCurrentItem];
        [self setItemView:itemView atIndex:self.indexOfCurrentItem];
        [self preloadItemViewForIndex:self.indexOfCurrentItem];
    }
    
    [self.control imageBrowserView:self
                     excuteCommand:MttImageBrowserControlCommandSwitchToAnother
                     withParameter:@(self.indexOfCurrentItem)];
}

- (void)reloadData {
    [self reloadDataAtIndex:0];
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
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTap:)];
    doubleTapGestureRecognizer.delegate = self;
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTapGestureRecognizer];
    
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
}

- (void)onSingleTap:(UITapGestureRecognizer *)gestureRecognizer {
    [self setMaskHidden:!self.isMaskHidden animated:YES];
}

- (void)onDoubleTap:(UITapGestureRecognizer *)gestureRecognizer {
    MttImageBrowserItemView * currentItemView = [self imageBrowserItemViewAtIndex:self.indexOfCurrentItem];
    [currentItemView autoZoomWithAnimated:YES];
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
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.indexOfCurrentItem = [self currentItemIndexWithScrollView:scrollView];
    // update items
    if (![self imageBrowserItemViewAtIndex:self.indexOfCurrentItem]) {
        [self loadItemViewForIndex:self.indexOfCurrentItem];
    }
    [self dismissItemViewForIndex:self.indexOfCurrentItem];
    [self preloadItemViewForIndex:self.indexOfCurrentItem];
    
    // TODO: update thumbnails
}

#pragma mark - MttImageBrowserControl
- (void)imageBrowserView:(UIView *)view
           excuteCommand:(MttImageBrowserControlCommand)command
           withParameter:(id)parameter {
    
}

#pragma mark - items
- (MttImageBrowserItemView *)imageBrowserItemViewAtIndex:(NSUInteger)index {
    return self.items[@(index)];
}

- (void)setItemView:(MttImageBrowserItemView *)itemView atIndex:(NSUInteger)index {
    MttImageBrowserItemView * oldItem = [self imageBrowserItemViewAtIndex:index];
    if (oldItem) {
        [oldItem removeFromSuperview];
    }
    
    const CGFloat itemWidth = CGRectGetWidth(self.bounds);
    const CGFloat itemheight = CGRectGetHeight(self.bounds);
    itemView.frame = CGRectMake(index * itemWidth, 0, itemWidth, itemheight);
    [self.scrollView addSubview:itemView];
    
    self.items[@(index)] = itemView;
}

- (void)preloadItemViewForIndex:(NSUInteger)index {
    if (![self.dataSource respondsToSelector:@selector(imageBrowserView:itemAtIndex:)]) {
        return;
    }
    
    if (index >= 1 &&
        ![self imageBrowserItemViewAtIndex:index - 1]) {
        
        MttImageBrowserItemView *itemView = [self.dataSource imageBrowserView:self itemAtIndex:index - 1];
        [self setItemView:itemView atIndex:index - 1];
    }
    
    NSUInteger itemCount = [self.dataSource numberOfItemsInImageBrowserView:self];
    if (index < itemCount - 1 &&
        ![self imageBrowserItemViewAtIndex:index + 1]) {
        
        MttImageBrowserItemView *itemView = [self.dataSource imageBrowserView:self itemAtIndex:index + 1];
        [self setItemView:itemView atIndex:index + 1];
    }
}

- (NSUInteger)currentItemIndexWithScrollView:(UIScrollView *)scrollView {
    NSUInteger index = 0;
    CGFloat offsetX = scrollView.contentOffset.x;
    index = (NSUInteger)(offsetX / CGRectGetWidth(self.bounds));
    return index;
}

- (void)dismissItemViewForIndex:(NSUInteger)index {
    NSUInteger itemCount = [self.dataSource numberOfItemsInImageBrowserView:self];
    for (NSUInteger i = 0; i < itemCount; ++i) {
        if (i < self.indexOfCurrentItem - 1
            || i > self.indexOfCurrentItem + 1) {
            
            MttImageBrowserItemView * itemView = [self imageBrowserItemViewAtIndex:i];
            [itemView removeFromSuperview];
            [self.items removeObjectForKey:@(i)];
        }
    }
}

- (void)loadItemViewForIndex:(NSUInteger)index {
    if (![self.dataSource respondsToSelector:@selector(imageBrowserView:itemAtIndex:)]) {
        return;
    }
    
    MttImageBrowserItemView * itemView = [self.dataSource imageBrowserView:self itemAtIndex:index];
    [self setItemView:itemView atIndex:index];
}
@end
