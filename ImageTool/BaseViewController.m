//
//  BaseViewController.m
//  ImageTool
//
//  Created by HuDaQian on 2017/2/16.
//  Copyright © 2017年 HuXiaoQian. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBaseView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createBaseView {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-300)/2, 100, 300, 300)];
    [imageV setImage:[UIImage imageNamed:@"Github-Security"]];
    [self.view addSubview:imageV];
    self.leftResultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+(Screen_Width-300)/2, 410, 140, 140)];
    self.leftResultImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.leftResultImageView];
    self.rightResultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(160+(Screen_Width-300)/2, 410, 140, 140)];
    self.rightResultImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.rightResultImageView];
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
