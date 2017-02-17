//
//  ScaleImageViewController.m
//  ImageTool
//
//  Created by HuDaQian on 2017/2/16.
//  Copyright © 2017年 HuXiaoQian. All rights reserved.
//

#import "ScaleImageViewController.h"

@interface ScaleImageViewController ()

@end

@implementation ScaleImageViewController

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
    [self.leftResultImageView setImage:[ImageEditTool scaleImage:initialImage scale:0.3]];
    [self.rightResultImageView setImage:[ImageEditTool scaleImage:initialImage withWidth:0.3 andHeight:0.2]];
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
