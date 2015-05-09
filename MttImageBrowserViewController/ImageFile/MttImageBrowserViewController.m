//
//  MttImageBrowserViewController
//  MttImageBrowserViewController
//
//  Created by vectorliu on 15/5/9.
//  Copyright (c) 2015年 vectorliu. All rights reserved.
//

#import "MttImageBrowserViewController.h"
#import "MttImageBrowserView.h"

@interface MttImageBrowserViewController ()

@end

@implementation MttImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageBrowserView = [[MttImageBrowserView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageBrowserView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
