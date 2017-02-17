//
//  CutImageViewController.m
//  ImageTool
//
//  Created by HuDaQian on 2017/2/16.
//  Copyright © 2017年 HuXiaoQian. All rights reserved.
//

#import "CutImageViewController.h"

@interface CutImageViewController ()

@end

@implementation CutImageViewController

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
    [self.leftResultImageView setImage:[ImageEditTool cutImageWithImage:initialImage imageViewSize:CGSizeMake(300, 300) cutRect:CGRectMake(0, 0, 300, 150)]];
    CGPoint aPoint = CGPointMake(10, 10);
    CGPoint bPoint = CGPointMake(290, 10);
    CGPoint cPoint = CGPointMake(290, 290);
    CGPoint dPoint = CGPointMake(100, 100);
    CGPoint ePoint = CGPointMake(250, 50);
    CGPoint fPoint = CGPointMake(10, 50);
    [self.rightResultImageView setImage:[ImageEditTool cutImageWithImage:initialImage imageViewSize:CGSizeMake(300, 300) clipPoints:@[[NSValue valueWithCGPoint:aPoint],[NSValue valueWithCGPoint:bPoint],[NSValue valueWithCGPoint:cPoint],[NSValue valueWithCGPoint:dPoint],[NSValue valueWithCGPoint:ePoint],[NSValue valueWithCGPoint:fPoint]]]];
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
