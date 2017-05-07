//
//  LDJAlertView.m
//  SelectedTime
//
//  Created by huadian’mac on 17/5/6.
//  Copyright © 2017年 刘德娟. All rights reserved.
//

#import "LDJAlertView.h"

#define SCALE [[UIScreen mainScreen] bounds].size.width/375

/*
 把pickerView放到了AlertView上面
 注意: 当没有滚动选择的时候, 默认返回的数据returnDic是每列的第一行
 当selectArr有数据的时候, 默认选择的是每列传递过来的数据
 在数组的set方法中, 刷新一下pickerView, 因为, 开始先创建pickerView,后拿到数据, 所以需要在set方法中, 拿到数据后, 刷新一下
 
 */


@implementation LDJAlertView
{
    UIView *view;
    int tag;
    UIPickerView *Dpicker;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)initWithTitle:(NSString *)str andCancelBtn:(NSString *)cancel andOtherBtn:(NSString *)other {
   
    self.returnDic = [NSMutableDictionary dictionary];
    
    //CGRectMake(0, 20, self.view.frame.size.width-20, 200)]
    Dpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 5*SCALE, self.bounds.size.width, self.bounds.size.height - 40*SCALE)];
    Dpicker.delegate  = self;
    Dpicker.dataSource = self;
    Dpicker.showsSelectionIndicator = YES;
    [self addSubview:Dpicker];
    
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth =  1;
    self.layer.cornerRadius = 15;
    [self.layer setMasksToBounds:YES];
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(5*SCALE, 10*SCALE, self.frame.size.width-10*SCALE, 15*SCALE)];
    _title.text = str;
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = [UIFont systemFontOfSize:20*SCALE];
    _title.textColor = [UIColor blackColor];
    [self addSubview:_title];
    
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn addTarget:self action:@selector(selectbtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:cancel forState:0];
    _cancelBtn.tag = 1;
    _cancelBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _cancelBtn.layer.borderWidth = 1;
    _cancelBtn.layer.cornerRadius = 4;
    [_cancelBtn.layer setMasksToBounds:YES];
    [_cancelBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn addTarget:self action:@selector(selectbtn:) forControlEvents:UIControlEventTouchUpInside];
    [_sureBtn setTitle:other forState:0];
    _sureBtn.tag = 2;
    _sureBtn.layer.borderColor = [UIColor colorWithRed:0 green:128 blue:100 alpha:1.0].CGColor;
    _sureBtn.layer.borderWidth = 1;
    _sureBtn.layer.cornerRadius = 4;
    [_sureBtn.layer setMasksToBounds:YES];
    [_sureBtn setTitleColor:[UIColor colorWithRed:0 green:128 blue:100 alpha:1] forState:(UIControlStateNormal)];
   // [cancelBtn setBackgroundColor:[UIColor lightGrayColor]];
   // [sureBtn setBackgroundColor:[UIColor greenColor]];
    
    _cancelBtn.frame = CGRectMake(10*SCALE, self.frame.size.height-45*SCALE, self.frame.size.width/2-20*SCALE, 35*SCALE);
    [self addSubview:_cancelBtn];
    
    _sureBtn.frame = CGRectMake(self.frame.size.width/2+10*SCALE, self.frame.size.height-45*SCALE, self.frame.size.width/2-20*SCALE, 35*SCALE);
    [self addSubview:_sureBtn];
    
  /*  if (cancel == nil &&other != nil) {
        sureBtn.frame = CGRectMake(10, self.frame.size.height-45, 260, 35);
        sureBtn.layer.borderColor = [UIColor clearColor].CGColor;
        sureBtn.layer.borderWidth =  1;
        sureBtn.layer.cornerRadius = 5;
        [sureBtn.layer setMasksToBounds:YES];
        [self addSubview:sureBtn];
    }else if(cancel != nil &&other == nil)
    {
        cancelBtn.frame = CGRectMake(10, self.frame.size.height-45, 260, 35);
        cancelBtn.layer.borderColor = [UIColor clearColor].CGColor;
        cancelBtn.layer.borderWidth =  1;
        cancelBtn.layer.cornerRadius = 5;
        [cancelBtn.layer setMasksToBounds:YES];
        [self addSubview:cancelBtn];
    }else
    {
        cancelBtn.frame = CGRectMake(10, self.frame.size.height-45, self.frame.size.width/2-20, 35);
        [self addSubview:cancelBtn];
        
        sureBtn.frame = CGRectMake(self.frame.size.width/2+10, self.frame.size.height-45, self.frame.size.width/2-20, 35);
        [self addSubview:sureBtn];
    }*/


}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    
    [Dpicker reloadAllComponents];//刷新pickerView
    for (NSDictionary *dic in dataArr) {
        [self.returnDic setValue:dic.allValues[0][0] forKey:dic.allKeys[0] ];
    } // 如果没有滚动选择, 默认返回的都是每列的第一行 self.returnDic
    
}

- (void)setSelectArr:(NSArray *)selectArr{
    _selectArr = selectArr;
    
    if (selectArr.count > self.dataArr.count) {
        return; //数据selectArr数据传递错误的话, 返回, 防崩
    }
    // 系统默认选择每列第一行, 如果传递过来的selectArr有值的话,那么就选择指定的行selectRow:inComponent:
    // 相应的改变下, 返回的returnDic, 不走下面的did方法的话,就返回,传递进来的行[即selectArr]
    for (int i = 0; i < selectArr.count; i ++) {
        NSString *str = selectArr[i];
        NSDictionary *dic = self.dataArr[i];
        NSArray *arr = dic.allValues[0];
        int index = (int)[arr indexOfObject:str];
        [self.returnDic setValue:str forKey:dic.allKeys[0]];
        [Dpicker selectRow:index inComponent:i animated:YES];
    }

    
}


//点击
-(void)selectbtn:(id)sender
{
    [self dismmis];
    UIButton *btn = (UIButton *)sender;
    if(btn.tag == 2){
    [self.delegate btnIndex:self.returnDic]; //通过代理把选择的数据,传递到textFied上显示
    }
}


#pragma mark - pickerview
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return self.dataArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    NSDictionary *dic = self.dataArr[component];

    return [dic.allValues[0] count];
    
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    
    UILabel *mycom1 = [[UILabel alloc] init];
    mycom1.textAlignment = NSTextAlignmentCenter;
    mycom1.backgroundColor = [UIColor clearColor];
    mycom1.frame = CGRectMake(0, 0, self.frame.size.width/self.dataArr.count, 50*SCALE);
    [mycom1 setFont:[UIFont boldSystemFontOfSize:16*SCALE]];
    
    NSDictionary *dic = self.dataArr[component];
    mycom1.text = dic.allValues[0][row];

    
    return mycom1;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.frame.size.width/self.dataArr.count;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSDictionary *dic = self.dataArr[component];
    NSString *key = dic.allKeys[0];
    // 如果滚动选择了, 又会覆盖上面的 self.returnDic, 返回选择的数据
    [self.returnDic setValue:dic.allValues[0][row] forKey:key];
    
}



//出现
-(void)show
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    view = [[UIView alloc] initWithFrame:keyWindow.bounds];
    view.alpha = 0.3;
    view.backgroundColor = [UIColor blackColor];
    [keyWindow addSubview:view];
    
    self.alpha = 1;
    [keyWindow addSubview:self];
    [keyWindow bringSubviewToFront:self];
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
    bounceAnimation.duration = 0.3;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.01],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    
    [self.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
    
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animation];
    fadeInAnimation.duration = 0.3;
    fadeInAnimation.fromValue = [NSNumber numberWithFloat:0];
    fadeInAnimation.toValue = [NSNumber numberWithFloat:1];
    [self.superview.layer addAnimation:fadeInAnimation forKey:@"opacity"];
}

//消失
-(void)dismmis
{
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(0.01, 0.01));
         view.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         [view removeFromSuperview];
         [self removeFromSuperview];
         
     }];
}




@end
