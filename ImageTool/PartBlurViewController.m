//
//  PartBlurViewController.m
//  ImageTool
//
//  Created by HuDaQian on 2017/2/16.
//  Copyright © 2017年 HuXiaoQian. All rights reserved.
//

#import "PartBlurViewController.h"

@interface PartBlurViewController ()

@end

@implementation PartBlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self getCIGaussianBlur];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView {
    UIImage *initialImage = [UIImage imageNamed:@"Github-Security"];
//    [self.leftResultImageView setImage:[ImageEditTool addMarkAtImage:initialImage withImage:[ImageEditTool createApureColorImageWithColor:[UIColor purpleColor]] atRect:CGRectMake(10, 10, 50, 50)]];
    UIImage *textMarkImage = [ImageEditTool addMarkAtImage:initialImage withText:@"edit:九点" rect:CGRectMake(0, 0, 160, 40) andAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:40.0f]}];
    [self.leftResultImageView setImage:textMarkImage];
}

- (void)getCIGaussianBlur {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^(void){
        UIImage *initialImage = [UIImage imageNamed:@"Github-Security"];
        UIImage *textMarkImage = [ImageEditTool addMarkAtImage:initialImage withText:@"edit:九点" rect:CGRectMake(0, 0, 160, 40) andAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:40.0f]}];
        UIImage *blurImage = [ImageEditTool coreBlurImage:textMarkImage imageViewSize:CGSizeMake(300, 300) withBlurNumber:10 withRect:CGRectMake(0, 0, 160, 40)];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.rightResultImageView setImage:blurImage];
        });
    });
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
