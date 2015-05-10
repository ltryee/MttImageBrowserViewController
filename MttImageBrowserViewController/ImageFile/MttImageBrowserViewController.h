//
//  MttImageBrowserViewController 
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/9.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MttImageBrowserViewDelegate.h"

@class MttImageBrowserView;

@interface MttImageBrowserViewController : UIViewController<MttImageBrowserViewDataSource, MttImageBrowserControl>
@property (nonatomic, strong) MttImageBrowserView *imageBrowserView;
@end
