//
//  P1ViewController.m
//  Project1
//
//  Created by zhangchu on 16/8/15.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "P1ViewController.h"
#import "PublicContext.h"
@interface P1ViewController ()
@property(nonatomic,strong)UITextField *field;
@end

@implementation P1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.field=[[UITextField alloc]initWithFrame:CGRectMake(50, 200, 200, 30)];
    [self.field setBackgroundColor:[UIColor whiteColor]];
    [self.field setPlaceholder:@"输入一个数字"];
    [self.view addSubview:self.field];
    [self.view setBackgroundColor:[UIColor greenColor]];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(50, 320, 200, 50)];
    button.backgroundColor=[UIColor whiteColor];
    [button setTitle:@"getServiceFromP2" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view from its nib.
}
-(void)buttonClick:(id)sender{
    [ServiceManager loadService:@"P2Service" withParams:@{@"NUMBER":@(self.field.text.floatValue)} withCallBack:^(NSDictionary *result){
        if (result) {
            [self.field setText:[NSString stringWithFormat:@"%.2f的平方根是：%@",self.field.text.floatValue,result[@"NUMBER"]]];
        }
    } synchronous:NO];
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
