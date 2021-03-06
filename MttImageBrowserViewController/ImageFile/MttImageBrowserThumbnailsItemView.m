//
//  MttImageBrowserThumbnailsItemView.m
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/10.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#import "MttImageBrowserThumbnailsItemView.h"

@interface MttImageBrowserThumbnailsItemView()
@property (nonatomic, strong) UIImageView *selectionMask;
@end

@implementation MttImageBrowserThumbnailsItemView

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.imageView.image = image;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
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

- (UIImageView *)selectionMask {
    if (!_selectionMask) {
        _selectionMask = [[UIImageView alloc] initWithFrame:self.bounds];
        _selectionMask.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        // TODO: set mask image
        [self addSubview:_selectionMask];
    }
    return _selectionMask;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.selectionMask.hidden = !selected;
}

@end
