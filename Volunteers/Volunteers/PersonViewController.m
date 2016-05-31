//
//  PersonViewController.m
//  Volunteer
//
//  Created by l k j y on 16/5/25.
//  Copyright © 2016年 康康. All rights reserved.
//

#import "PersonViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "Constants.h"
#import "NameViewController.h"
#import "WechatViewController.h"
#import "IntroViewController.h"
#import "SettingViewController.h"
#import "AddressViewController.h"
#import "SignerViewController.h"


#define rad(degrees) ((degrees) / (180.0 / M_PI))
typedef NS_ENUM(NSInteger, PhotoType)
{
    PhotoTypeIcon,
};

@interface PersonViewController () <UITableViewDelegate,UITableViewDataSource>

{
  
    NameViewController *nameVC;
    WechatViewController *weChatVC ;
    IntroViewController *introVC;
    SettingViewController *settingVC;
    AddressViewController *addressVC;
    SignerViewController *signerVC;
    
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSArray *array;
@property (nonatomic,copy) NSArray *views;
@property (nonatomic,assign) PhotoType type;
@property (nonatomic,copy) UIImageView *imageView;
@end

static NSString *AccountCellID = @"AccountCell";
static NSString *OtherCellID = @"OtherCell";
@implementation PersonViewController
#pragma mark - View Lifecycle
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_person"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectdImage = [[UIImage imageNamed:@"tabbar_item_person_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //底部导航item
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:nil tag:0];
        tabBarItem.image = deselectedImage;
        tabBarItem.selectedImage = selectdImage;
        self.tabBarItem = tabBarItem;
        
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self setUpViews];
    [self initVCs];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nightModeSwitch:) name:@"DKNightVersionNightFallingNotification" object:nil ];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nightModeSwitch:) name:@"DKNightVersionDawnComingNotification" object:nil];
   //self.array = @[@"头像",@"等级",@"名字",@"微信",@"个人简介",@"地址",@"个性签名",@"设置" ];
    //self.views = @[userInfo,nameVC,weChatVC];
    
 
    
}
-(void)initVCs
{
    nameVC = [[NameViewController alloc]init];
    signerVC = [[SignerViewController alloc]init];
    weChatVC = [[WechatViewController alloc]init];
    introVC = [[IntroViewController alloc]init];
    addressVC = [[AddressViewController alloc]init];
    settingVC = [[SettingViewController alloc]init];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:229 / 255.0];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark --NSNotification
-(void)nightModeSwitch:(NSNotification*)notificaton
{
    [self.tableView reloadData];
}

#pragma mark - Private
-(void)setUpViews
{
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - CGRectGetHeight(self.tabBarController.tabBar.frame))];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStyleGrouped];
    //不显示空cell
    self.tableView.tableFooterView = [[UIView alloc] init];
    //设置cell的行高，
    self.tableView.rowHeight = 70;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置分割线
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AccountCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OtherCellID];
    self.tableView .backgroundColor = [UIColor whiteColor];
    self.tableView.nightBackgroundColor = NightBGViewColor;
    self.tableView.separatorColor = TableViewCellSeparatorDawnColor;
    self.tableView.nightSeparatorColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
}
#pragma  mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = indexPath.row ==0 ? AccountCellID:OtherCellID;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"头像";
        //cell.imageView.image = [UIImage imageNamed:@"person_icon"];
        UIGestureRecognizer *tap = [[UIGestureRecognizer alloc]initWithTarget:cell action:@selector(selectedIcon)];
        [cell.imageView addGestureRecognizer:tap];
        cell.imageView.image = _imageView.image;
    }else if (indexPath.row == 1)
    {
        
        cell.textLabel.text = @"等级";
    }else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"名字";
       cell.detailTextLabel.text = @"asf";
        
               
    }else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"微信";
    }else if (indexPath.row == 4)
    {
        cell.textLabel.text = @"个人简介";
    }else if (indexPath.row == 5)
    {
        cell.textLabel.text = @"地址";
       
    }else if (indexPath.row == 6)
    {
        cell.textLabel.text = @"个性签名";
       
    }else if (indexPath.row == 7)
    {
        cell.textLabel.text = @"设置";
        cell.imageView.image = [UIImage imageNamed:@"AppIcon1"];
    }
//    for (int i=0; i < [_array count]; i++)
//    {
//        if (indexPath.row == i)
//        {
//            cell.textLabel.text = _array[i];
//        }
//    }
    
    cell.textLabel.textColor = DawnTextColor;
    cell.textLabel.nightTextColor = NightTextColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor whiteColor];
    cell.nightBackgroundColor = NightBGViewColor;
    
    return cell;
}
#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        UIAlertController *alertController = [[UIAlertController alloc]init];
        
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
            
            if ([controller isAvailableCamera] && [controller isSupportTakingPhotos]) {
                [controller setDelegate:self];
                [self presentViewController:controller animated:YES completion:nil];
            }else
            {
                NSLog(@"%s %@", __FUNCTION__, @"相机权限受限");
            }
        }];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [controller setDelegate:self];
            if ([controller isAvailablePhotoLibrary]) {
                [self presentViewController:controller animated:YES completion:nil];
            }    }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alertController addAction:action0];
        [alertController addAction:action1];
        [alertController addAction:action2];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    if (indexPath.row == 1)
    {
      
    }
    if (indexPath.row == 2)
    {
       // NameViewController *nameVC = [[NameViewController alloc]init];
        
       [self.navigationController pushViewController:nameVC animated:YES];
    
    }
    if (indexPath.row == 3)
    {
        [self.navigationController pushViewController:weChatVC animated:YES];
    }
    if (indexPath.row == 4)
    {
        [self.navigationController pushViewController:introVC animated:YES];
    }
    if (indexPath.row == 5)
    {
     [self.navigationController pushViewController:addressVC animated:YES];
    }
    if (indexPath.row == 6)
    {
        [self.navigationController pushViewController:signerVC animated:YES];
    }
    if (indexPath.row == 7)
    {
     [self.navigationController pushViewController:settingVC animated:YES];
    }
}
#pragma mark - 头像
-(void)selectedIcon
{
    self.type = PhotoTypeIcon;
//    [self editImageSelected];
}
#pragma mark ---编辑视图点击事件---
//- (void)editImageSelected
//{
//    UIAlertController *alertController = [[UIAlertController alloc]init];
//    
//    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
//        
//        if ([controller isAvailableCamera] && [controller isSupportTakingPhotos]) {
//            [controller setDelegate:self];
//            [self presentViewController:controller animated:YES completion:nil];
//        }else
//        {
//            NSLog(@"%s %@", __FUNCTION__, @"相机权限受限");
//        }
//    }];
//    
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        [controller setDelegate:self];
//        if ([controller isAvailablePhotoLibrary]) {
//            [self presentViewController:controller animated:YES completion:nil];
//        }    }];
//    
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    
//    [alertController addAction:action0];
//    [alertController addAction:action1];
//    [alertController addAction:action2];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//}



/**
 *  STPhotoKitDelegate代理实现
 *
 */
- (void)photoKitController:(STPhotoKitController *)photoKitController resultImage:(UIImage *)resultImage
{
    switch (self.type)
    {
        case PhotoTypeIcon:
            self.imageView.image = resultImage;
            break;
        default:
            break;
    }
}

/**
 *  UIImagePickerController 代理实现
 *
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^
     {
         UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
         STPhotoKitController *photoVC = [STPhotoKitController new];
         [photoVC setDelegate:self];
         [photoVC setImageOriginal:imageOriginal];
         switch (self.type)
         {
             case PhotoTypeIcon:
                 [photoVC setSizeClip:CGSizeMake(50, 50)];
                 break;
         }
         
         [self presentViewController:photoVC animated:YES completion:nil];
         
     }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^()
     {
     }];
}



@end


