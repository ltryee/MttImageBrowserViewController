//
//  MttImageBrowserViewController
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/9.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#import "MttImageBrowserViewController.h"
#import "MttImageBrowserView.h"
#import "MttImageBrowserItemView.h"
#import "MttImageBrowserThumbnailsItemView.h"

@interface MttImageBrowserViewController ()

@end

@implementation MttImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageBrowserView = [[MttImageBrowserView alloc] initWithFrame:self.view.bounds];
    self.imageBrowserView.dataSource = self;
    [self.view addSubview:self.imageBrowserView];
    
    [self.imageBrowserView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MttImageBrowserViewDataSource
- (NSUInteger)numberOfItemsInImageBrowserView:(MttImageBrowserView *)imageBrowserView {
    return 8;
}

- (MttImageBrowserItemView *)imageBrowserView:(MttImageBrowserView *)imageBrowserView itemAtIndex:(NSUInteger)index {

    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)(index + 1)]];
    MttImageBrowserItemView *itemView = [[MttImageBrowserItemView alloc] initWithImage:image];
    return itemView;
}

- (MttImageBrowserThumbnailsItemView *)imageBrowserView:(MttImageBrowserView *)imageBrowserView thumbnailItemAtIndex:(NSUInteger)index {
    
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)(index + 1)]];
    MttImageBrowserThumbnailsItemView *itemView = [[MttImageBrowserThumbnailsItemView alloc] initWithImage:image];
    return itemView;
}

#pragma mark - MttImageBrowserControl
- (void)imageBrowserView:(UIView *)view
           excuteCommand:(MttImageBrowserControlCommand)command
           withParameter:(id)parameter {

    [self.imageBrowserView imageBrowserView:view
                              excuteCommand:command
                              withParameter:parameter];
}

@end
