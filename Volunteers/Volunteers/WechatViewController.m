//
//  WechatViewController.m
//  Volunteer
//
//  Created by l k j y on 16/5/28.
//  Copyright © 2016年 康康. All rights reserved.
//

#import "WechatViewController.h"
#import "PersonViewController.h"

@interface WechatViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *wxNumber;



@end

@implementation WechatViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"微信号";
    titleLabel.textColor = TitleTextColor;
    titleLabel.nightTextColor = TitleTextColor;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000] ;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveTap)];
    save.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = save;
    
    
    
    [self setViews];
    
}
-(void)setViews
{
    self.wxNumber = [[UITextField alloc]initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, 50)];
    self.wxNumber.backgroundColor = [UIColor whiteColor];
    self.wxNumber.nightBackgroundColor = NightBGViewColor;
    self.wxNumber.adjustsFontSizeToFitWidth = YES;
    self.wxNumber.minimumFontSize = 0.5f;
    self.wxNumber.placeholder = @"请输入您的微信号";
    self.wxNumber.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.wxNumber];
    
    
    
    
    self.wxNumber.delegate = self;
    
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.wxNumber becomeFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.wxNumber)
    {
        [self.wxNumber resignFirstResponder];
        NSLog(@"%@",self.wxNumber.text);
    }
}
-(void)saveTap
{
    
    PersonViewController *personVC = [[PersonViewController alloc]init];
    personVC.value = _wxNumber.text;
    [self presentViewController:personVC animated:YES completion:nil];
    
}

@end
