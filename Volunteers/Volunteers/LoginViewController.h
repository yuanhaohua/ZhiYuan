//
//  LoginViewController.h
//  Volunteer
//
//  Created by l k j y on 16/5/30.
//  Copyright © 2016年 康康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(id)sender;

- (IBAction)registered:(id)sender;

@end
