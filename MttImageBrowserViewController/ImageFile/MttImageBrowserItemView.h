//
//  MttImageBrowserCellView.h
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/9.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MttImageBrowserItemView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) NSInteger index;

- (id)initWithImage:(UIImage *)image;
- (void)autoZoomWithAnimated:(BOOL)animated;

@end
