//
//  MttImageBrowserToolbarView.h
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/9.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MttImageBrowserViewDelegate.h"

@interface MttImageBrowserToolbarView : UIView
@property (nonatomic, weak) id<MttImageBrowserControl> control;
@property (nonatomic, strong) NSString *title;
@end
