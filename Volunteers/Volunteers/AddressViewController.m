//
//  AddressViewController.m
//  Volunteer
//
//  Created by l k j y on 16/5/30.
//  Copyright © 2016年 康康. All rights reserved.
//

#import "AddressViewController.h"
#import "PersonViewController.h"
@interface AddressViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField ;
@end
@implementation AddressViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"地址";
    titleLabel.textColor = TitleTextColor;
    titleLabel.nightTextColor = TitleTextColor;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000] ;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveTap)];
    save.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = save;
    //   [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self setViews];
    
}
-(void)setViews
{
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, 80)];
    
    self.textField.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    self.textField.font = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小
    self.textField.delegate = self;//设置它的委托方法
    self.textField.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    self.textField.nightBackgroundColor =NightBGViewColor;
    self.textField.placeholder = @"请输入你的地址,输入省市即可";
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.textField];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.textField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 20) {
            return NO;
        }
    }
    
    return YES;
}
-(void)saveTap
{
    
    PersonViewController *personVC = [[PersonViewController alloc]init];
    personVC.value = _textField.text;
    [self presentViewController:personVC animated:YES completion:nil];
    
}
@end
