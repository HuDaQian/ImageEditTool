//
//  ViewController.m
//  ImageTool
//
//  Created by HuDaQian on 2017/2/10.
//  Copyright © 2017年 HuXiaoQian. All rights reserved.
//

#import "ViewController.h"

#import "SingularityColorViewController.h"
#import "ScaleImageViewController.h"
#import "TextMarkImageViewController.h"
#import "WipeSnapImageViewController.h"
#import "PartBlurViewController.h"
#import "CutImageViewController.h"

#import "ImageEditTool.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *listTableView;
}
@property (nonatomic, retain) NSArray *listArray;
@property (nonatomic, retain) NSArray *listViewControllerArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView {
    self.title = @"图片处理";
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"listCell"];
    listTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:listTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    cell.textLabel.text = [_listArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_listViewControllerArray count] > indexPath.row) {
        Class nextControllerClass = NSClassFromString([_listViewControllerArray objectAtIndex:indexPath.row]);
        NSAssert(nextControllerClass != nil, @"Class isnot Exitst!");
        UIViewController *nextController = [(UIViewController *)[nextControllerClass alloc] init];
        nextController.title = [_listArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:nextController animated:YES];
    }
}

- (void)initData {
    _listArray = @[@"单色图片生成",@"图片缩放",@"文字水印",@"图片擦除与快照",@"局部高斯模糊",@"图片裁剪"];
    _listViewControllerArray = @[@"SingularityColorViewController",@"ScaleImageViewController",@"TextMarkImageViewController",@"WipeSnapImageViewController",@"PartBlurViewController",@"CutImageViewController"];
}

@end
