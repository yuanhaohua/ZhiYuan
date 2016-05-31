//
//  LoginViewController.m
//  Volunteer
//
//  Created by l k j y on 16/5/30.
//  Copyright © 2016年 康康. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
{
    RegisterViewController *registerVC;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    registerVC = [[RegisterViewController alloc]init];
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

- (IBAction)login:(id)sender
{
    
}

- (IBAction)registered:(id)sender
{
    [self.navigationController pushViewController:registerVC animated:YES];
}


@end
