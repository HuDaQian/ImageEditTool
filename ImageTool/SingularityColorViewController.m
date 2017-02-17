//
//  SingularityColorViewController.m
//  ImageTool
//
//  Created by HuDaQian on 2017/2/16.
//  Copyright © 2017年 HuXiaoQian. All rights reserved.
//

#import "SingularityColorViewController.h"

@interface SingularityColorViewController ()

@end

@implementation SingularityColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView {
    [self.leftResultImageView setImage:[ImageEditTool createApureColorImageWithColor:[UIColor cyanColor]]];
    [self.rightResultImageView setImage:[ImageEditTool createAPureColorImageWithColor:[UIColor orangeColor] andSize:CGSizeMake(100, 100)]];
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
