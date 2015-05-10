//
//  MttImageBrowserCellView.m
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/9.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#import "MttImageBrowserItemView.h"

@implementation MttImageBrowserItemView

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.imageView.image = image;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 3.0;
        self.delegate = self;
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (void)autoZoomWithAnimated:(BOOL)animated {
    if (self.zoomScale == 1) {
        [self setZoomScale:1.5 animated:YES];
    }
    else if (self.zoomScale > 1) {
        [self setZoomScale:1.0 animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.scrollEnabled = NO;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
                       withView:(UIView *)view
                        atScale:(CGFloat)scale {
    
    self.scrollEnabled = YES;
}

@end
