//
//  WipeImageViewController.m
//  ImageTool
//
//  Created by HuDaQian on 2017/2/16.
//  Copyright © 2017年 HuXiaoQian. All rights reserved.
//

#import "WipeSnapImageViewController.h"

@interface WipeSnapImageViewController (){
    UIImageView *coverView;
}

@end

@implementation WipeSnapImageViewController

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
    coverView = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-300)/2, 100, 300, 300)];
    [coverView setImage:[ImageEditTool addMarkAtImage:[ImageEditTool createAPureColorImageWithColor:[UIColor cyanColor] andSize:CGSizeMake(300, 300)] withText:@"刮刮乐" rect:CGRectMake(0,0,200,200) andAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:30.0f]}]
     ];
    coverView.userInteractionEnabled = YES;
    [self.view addSubview:coverView];
    
    UIPanGestureRecognizer *wipeGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(wipeAction:)];
    [coverView addGestureRecognizer:wipeGes];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((Screen_Width-100)/2, 80, 100, 20);
    [btn setTitle:@"快照" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)buttonClicked:(UIButton *)btn {
    [self.leftResultImageView setImage:[ImageEditTool snapImageWithView:coverView]];
}

- (void)wipeAction:(UISwipeGestureRecognizer *)wipeGes {
    [coverView setImage:[ImageEditTool wipeImageWithImageView:coverView point:[wipeGes locationInView:coverView] size:CGSizeMake(20, 20)]];
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
