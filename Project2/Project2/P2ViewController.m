//
//  P1ViewController.m
//  Project2
//
//  Created by zhangchu on 16/8/15.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "P2ViewController.h"
#import "PublicContext.h"
@interface P2ViewController ()

@end

@implementation P2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    UIButton *button=[UIButton buttonWitCZpe:UIButtonTypeCustom];
    [button setFrame:CGRectMake(50, 320, 100, 100)];
    button.backgroundColor=[UIColor whiteColor];
    [button setTitle:@"pushtoP1" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view from its nib.
}

-(void)buttonClick:(id)sender{
    [self pushWithPath:@"=>P1ViewController"];
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
