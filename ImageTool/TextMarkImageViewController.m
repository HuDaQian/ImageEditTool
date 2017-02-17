//
//  TextMarkImageViewController.m
//  ImageTool
//
//  Created by HuDaQian on 2017/2/16.
//  Copyright © 2017年 HuXiaoQian. All rights reserved.
//

#import "TextMarkImageViewController.h"

@interface TextMarkImageViewController ()

@end

@implementation TextMarkImageViewController

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
    UIImage *initialImage = [UIImage imageNamed:@"Github-Security"];
    [self.leftResultImageView setImage:[ImageEditTool addMarkAtImage:initialImage withText:@"edit:九点" point:CGPointMake(0, 0) andAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:30.0f]}]];
    [self.rightResultImageView setImage:[ImageEditTool addMarkAtImage:initialImage withText:@"edit:九点" rect:CGRectMake(40, 100, 100, 40) andAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:30.0f]}]];
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
