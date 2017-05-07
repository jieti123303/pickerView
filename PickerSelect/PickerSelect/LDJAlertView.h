//
//  LDJAlertView.h
//  SelectedTime
//
//  Created by huadian’mac on 17/5/6.
//  Copyright © 2017年 刘德娟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertDelegate <NSObject>

-(void)btnIndex:(NSDictionary *) returnDic;

@end

@interface LDJAlertView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>


@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableDictionary *returnDic;
@property (nonatomic, strong) NSArray *selectArr;


@property(nonatomic,retain)UILabel *title;
@property(nonatomic,retain)UIButton *cancelBtn;
@property(nonatomic,retain)UIButton *sureBtn;
@property (nonatomic,weak) id<CustomAlertDelegate> delegate;

-(void)initWithTitle:(NSString *)str andCancelBtn:(NSString *)cancel andOtherBtn:(NSString *)other;
-(void)show;
-(void)dismmis;


@end
