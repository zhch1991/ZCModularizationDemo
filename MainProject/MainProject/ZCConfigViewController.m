//
//  ZCConfigViewController.m
//  MainProject
//
//  Created by zhangchu on 16/11/22.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import "ZCConfigViewController.h"
#import "AppDelegate.h"

@interface ZCConfigViewController ()

@end

@implementation ZCConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    label.text = @"配置页面";
    label.backgroundColor = [UIColor purpleColor];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"完全版" forState:UIControlStateNormal];
    btn1.alpha = 0.6;
    [btn1 addTarget:self action:@selector(btn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 40)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"简化版1" forState:UIControlStateNormal];
    btn2.alpha = 0.6;
    [btn2 addTarget:self action:@selector(btn2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 40)];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"简化版2" forState:UIControlStateNormal];
    btn3.alpha = 0.6;
    [btn3 addTarget:self action:@selector(btn3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 40)];
    btn4.backgroundColor = [UIColor redColor];
    [btn4 setTitle:@"简化版3" forState:UIControlStateNormal];
    btn4.alpha = 0.6;
    [btn4 addTarget:self action:@selector(btn4Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)btn1Clicked:(UIButton *)btn1
{
    [self.navigationController popViewControllerAnimated:NO];
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) mode1];
}

- (void)btn2Clicked:(UIButton *)btn1
{
    [self.navigationController popViewControllerAnimated:NO];
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) mode2];
}

- (void)btn3Clicked:(UIButton *)btn1
{
    [self.navigationController popViewControllerAnimated:NO];
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) mode3];
}

- (void)btn4Clicked:(UIButton *)btn1
{
    [self.navigationController popViewControllerAnimated:NO];
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) mode4];
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
