//
//  ViewController.m
//  PickerSelect
//
//  Created by huadian’mac on 17/5/6.
//  Copyright © 2017年 刘德娟. All rights reserved.
//

#import "ViewController.h"
#import "LDJAlertView.h"

//屏幕的宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define SCALE [[UIScreen mainScreen] bounds].size.width/375

@interface ViewController ()<CustomAlertDelegate,UITextFieldDelegate>
{
    LDJAlertView *alert;
}

@property (nonatomic, strong) UITextField *textFied;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.textFied = [[UITextField alloc] initWithFrame:CGRectMake(100*SCALE, 200*SCALE, 250*SCALE, 50*SCALE)];
    self.textFied.delegate =self;
    self.textFied.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.textFied];

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    alert = [[LDJAlertView alloc] initWithFrame:CGRectMake(50, (ScreenHeight-200*SCALE)/2, ScreenWidth-100*SCALE, 300*SCALE)];
    alert.delegate = self;
    [alert initWithTitle:@"请选择日期" andCancelBtn:@"取消" andOtherBtn:@"确定"];
    alert.dataArr = @[@{@"nian":@[@"1年",@"2年",@"3年",@"4年",@"5年"]},@{@"yue":@[@"一月",@"二月",@"三月",@"四月"]},@{@"ri":@[@"1日",@"2日",@"3日",@"4日"]}];
    
    alert.selectArr = @[@"2年",@"三月",@"2日"]; //从后台传递过来的数据, 也就是textfield上的数据
    
    //把Dpicker添加到一个弹出框上展现出来
    [alert show];
    return NO;
}
- (void)btnIndex:(NSDictionary *)returnDic{
    
    [returnDic objectForKey:@"nian"];
    [returnDic objectForKey:@"yue"];
    [returnDic objectForKey:@"ri"];
    self.textFied.text = [NSString stringWithFormat:@"%@ %@ %@",[returnDic objectForKey:@"nian"],[returnDic objectForKey:@"yue"],[returnDic objectForKey:@"ri"]];
    NSLog(@"%@",returnDic);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
