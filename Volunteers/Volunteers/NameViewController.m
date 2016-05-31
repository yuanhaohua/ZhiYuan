//
//  NameViewController.m
//  Volunteer
//
//  Created by l k j y on 16/5/27.
//  Copyright © 2016年 康康. All rights reserved.
//

#import "NameViewController.h"
#import "PersonViewController.h"

@interface NameViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *name;



@end

@implementation NameViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"名字";
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
    self.name = [[UITextField alloc]initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, 50)];
    self.name.backgroundColor = [UIColor whiteColor];
    self.name.nightBackgroundColor = NightBGViewColor;
    self.name.adjustsFontSizeToFitWidth = YES;
    self.name.minimumFontSize = 0.5f;
    self.name.placeholder = @"请输入您的昵称";
    self.name.clearButtonMode = UITextFieldViewModeAlways;
     [self.view addSubview:self.name];
    
   
    
    
    self.name.delegate = self;
  

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.name becomeFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.name)
    {
        [self.name resignFirstResponder];
        NSLog(@"%@",self.name.text);
    }
}
-(void)saveTap
{
 
    PersonViewController *personVC = [[PersonViewController alloc]init];
    personVC.value = _name.text;
    [self presentViewController:personVC animated:YES completion:nil];
    
}
@end
