//
//  MttImageBrowserViewDelegate.h
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/10.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#ifndef MttImageBrowserViewController_MttImageBrowserViewDelegate_h
#define MttImageBrowserViewController_MttImageBrowserViewDelegate_h

typedef NS_ENUM(NSInteger, MttImageBrowserControlCommand) {
    MttImageBrowserControlCommandQuit = 0,
    MttImageBrowserControlCommandShrink,
    MttImageBrowserControlCommandZoom,
    MttImageBrowserControlCommandSwitchToAnother,
//    MttImageBrowserControlCommandShare,
//    MttImageBrowserControlCommandSaveToAlbum
};

@class MttImageBrowserView;
@class MttImageBrowserItemView;
@class MttImageBrowserThumbnailsItemView;
@class MttImageBrowserToolbarView;
@class MttImageBrowserThumbnailsView;

@protocol MttImageBrowserViewDataSource <NSObject>

@required
- (NSUInteger)numberOfItemsInImageBrowserView:(MttImageBrowserView *)imageBrowserView;

@optional
- (MttImageBrowserItemView *)imageBrowserView:(MttImageBrowserView *)imageBrowserView
                                  itemAtIndex:(NSUInteger)index;
- (MttImageBrowserThumbnailsItemView *)imageBrowserView:(MttImageBrowserView *)imageBrowserView
                                   thumbnailItemAtIndex:(NSUInteger)index;
- (NSString *)imageBrowserView:(MttImageBrowserView *)imageBrowserView
        titleForToolbarAtIndex:(NSUInteger)index;
- (MttImageBrowserToolbarView *)toolbarViewForImageBrowserView:(MttImageBrowserView *)imageBrowserView;
- (MttImageBrowserThumbnailsView *)thumbnailsViewForImageBrowserView:(MttImageBrowserView *)imageBrowserView;

@end

@protocol MttImageBrowserControl <NSObject>

- (void)imageBrowserView:(UIView *)view
           excuteCommand:(MttImageBrowserControlCommand)command
           withParameter:(id)parameter;

@end

#endif
