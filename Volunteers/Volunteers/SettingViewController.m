//
//  SettingViewController.m
//  Volunteer
//
//  Created by l k j y on 16/5/28.
//  Copyright © 2016年 康康. All rights reserved.
//

#import "SettingViewController.h"
#import "PersonViewController.h"
#import "LoginViewController.h"
#import "AppConfigure.h"

#define DawnViewBGColor [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1] // #EBEBEB
#define DawnCellBGColor [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1] // #F9F9F9
#define NightCellBGColor [UIColor colorWithRed:50 / 255.0 green:50 / 255.0 blue:50 / 255.0 alpha:1] // #323232
#define NightCellTextColor [UIColor colorWithRed:111 / 255.0 green:111 / 255.0 blue:111 / 255.0 alpha:1] // #6F6F6F
#define NightCellHeaderTextColor [UIColor colorWithRed:75 / 255.0 green:75 / 255.0 blue:75 / 255.0 alpha:1] // #4B4B4B

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    LoginViewController *loginVC;
}
@property (nonatomic,strong) UITableView *tableView;

@end
static NSString *CellHasDlzcID = @"HasDlacCell";
static NSString *CellHasSwitchID = @"HasSwitchCell";
static NSString *CellHasDIID = @"HasDICell";// DI -> DisclosureIndicator
static NSString *CellHasSecondLabelID = @"HasSecondLabelCell";
static NSString *CellLogOutID = @"LogOutCell";

@implementation SettingViewController
{
    NSArray *sectionHeaderTexts;
    NSArray *dataSource;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    loginVC = [[LoginViewController alloc]init];
    
    [self setUpViews];
    [self setTitleView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    sectionHeaderTexts = @[@"",@"浏览设置", @"缓存设置", @"更多", @""];
    dataSource = @[@[@"登录/注册"],
                   @[@"夜间模式切换"],
                   @[@"清除缓存"],
                   @[@"去评分", @"反馈", @"用户协议", @"版本号"],
                   @[@"退出当前账号"]];
    
}
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [self.tableView removeFromSuperview];
    self.tableView = nil;
}
-(void)setTitleView
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"设置";
    titleLabel.textColor = TitleTextColor;
    titleLabel.nightTextColor = TitleTextColor;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}
-(void)setUpViews
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    // 不显示空 cell
    self.tableView.tableFooterView = [[UIView alloc] init];
    // 设置 cell 的行高，固定为 44
    self.tableView.rowHeight = 44;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    
    
    
     [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellHasDlzcID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellHasSwitchID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellHasDIID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellHasSecondLabelID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellLogOutID];
    self.tableView.backgroundColor = DawnViewBGColor;
    self.tableView.nightBackgroundColor = NightBGViewColor;
    self.tableView.separatorColor = TableViewCellSeparatorDawnColor;
    self.tableView.nightSeparatorColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rowsData = dataSource[section];
    return rowsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID;
    
    switch (indexPath.section)
    {
        case 0:
            cellID = CellHasDlzcID;
            break;
        case 1:
            cellID = CellHasSwitchID;
            break;
        case 2:
        case 3: {
            if (indexPath.row < 3) {
                cellID = CellHasDIID;
            } else {
                cellID = CellHasSecondLabelID;
            }
        }
            break;
        case 4:
            cellID = CellLogOutID;
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = dataSource[indexPath.section][indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:128 / 255.0 green:127 / 255.0 blue:125 / 255.0 alpha:1];
    cell.textLabel.nightTextColor = NightCellTextColor;
    cell.textLabel.font = systemFont(17);
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0)
    {
    }
    else if (indexPath.section == 1)
    {
        UISwitch *nightModeSwitch = [[UISwitch alloc] init];
        nightModeSwitch.on = [AppConfigure boolForKey:APP_THEME_NIGHT_MODE];
        [nightModeSwitch addTarget:self action:@selector(nightModeSwitch:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = nightModeSwitch;
    } else if (indexPath.section == 3 && indexPath.row == 4)
    {
        UILabel *versionLabel = [UILabel new];
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        versionLabel.text = version;
        versionLabel.textColor = [UIColor colorWithRed:135 / 255.0 green:135 / 255.0 blue:135 / 255.0 alpha:1];
        versionLabel.nightTextColor = NightTextColor;
        versionLabel.font = systemFont(17);
        [versionLabel sizeToFit];
        cell.accessoryView = versionLabel;
    } else if (indexPath.section == 4)
    {// 退出当前账号
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.backgroundColor = DawnCellBGColor;
    cell.nightBackgroundColor = NightCellBGColor;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    headerView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(headerView.frame) - 40, CGRectGetHeight(headerView.frame))];
    headerLabel.text = sectionHeaderTexts[section];
    headerLabel.textColor = [UIColor colorWithRed:85 / 255.0 green:85 / 255.0 blue:85 / 255.0 alpha:1];
    headerLabel.nightTextColor = NightCellHeaderTextColor;
    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    [headerView addSubview:headerLabel];
    headerView.nightBackgroundColor = NightBGViewColor;
    
    return headerView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}

#pragma mark - Touch Events

- (void)nightModeSwitch:(UISwitch *)modeSwitch
{
    if (modeSwitch.isOn)
    {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:NightNavigationBarColor] forBarMetrics:UIBarMetricsDefault];
        self.tableView.backgroundColor = NightBGViewColor;
        [DKNightVersionManager nightFalling];
        [AppConfigure setBool:YES forKey:APP_THEME_NIGHT_MODE];
    } else
    {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:DawnNavigationBarColor] forBarMetrics:UIBarMetricsDefault];
        self.tableView.backgroundColor = DawnViewBGColor;
        [DKNightVersionManager dawnComing];
        self.tableView.backgroundColor = DawnViewBGColor;
        [AppConfigure setBool:NO forKey:APP_THEME_NIGHT_MODE];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Private

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark -- UITableViewDelegate


@end
