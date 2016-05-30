//
//  FriendsTableViewController.m
//  Volunteers
//
//  Created by yuan on 16/5/30.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "GlobalDefines.h"
#import "FriendsTableViewCell.h"
#import "ContactModel.h"
#import "DataGenerator.h"
#import "FriendsSearchResultController.h"
@interface FriendsTableViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;

@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:[FriendsSearchResultController new]];
    self.searchController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
    
    UISearchBar *bar = self.searchController.searchBar;
    bar.barStyle = UIBarStyleDefault;
    bar.translucent = YES;
    bar.barTintColor = Global_mainBackgroundColor;
    bar.tintColor = Global_tintColor;
    UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
    view.layer.borderColor = Global_mainBackgroundColor.CGColor;
    view.layer.borderWidth = 1;
    
    bar.layer.borderColor = [UIColor redColor].CGColor;
    
    bar.showsBookmarkButton = YES;
    [bar setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    bar.delegate = self;
    CGRect rect = bar.frame;
    rect.size.height = 44;
    bar.frame = rect;
    self.tableView.tableHeaderView = bar;
    self.tableView.rowHeight = [FriendsTableViewCell fixedHeight];
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self genDataWithCount:30];
    
    self.tableView.sectionHeaderHeight = 25;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)genDataWithCount:(NSInteger)count
{
    
    NSArray *xings = @[@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑",@"王",@"冯",@"陈",@"楚",@"卫",@"蒋",@"沈",@"韩",@"杨"];
    NSArray *ming1 = @[@"大",@"美",@"帅",@"应",@"超",@"海",@"江",@"湖",@"春",@"夏",@"秋",@"冬",@"上",@"左",@"有",@"纯"];
    NSArray *ming2 = @[@"强",@"好",@"领",@"亮",@"超",@"华",@"奎",@"海",@"工",@"青",@"红",@"潮",@"兵",@"垂",@"刚",@"山"];
    
    for (int i = 0; i < count; i++) {
        NSString *name = xings[arc4random_uniform((int)xings.count)];
        NSString *ming = ming1[arc4random_uniform((int)ming1.count)];
        name = [name stringByAppendingString:ming];
        if (arc4random_uniform(10) > 3) {
            NSString *ming = ming2[arc4random_uniform((int)ming2.count)];
            name = [name stringByAppendingString:ming];
        }
        ContactModel *model = [ContactModel new];
        model.name = name;
        model.imageName = [DataGenerator randomIconImageName];
        [self.dataArray addObject:model];
    }
    
    [self setUpTableSection];
}

- (void) setUpTableSection {
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //create a temp sectionArray
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray =  [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index<numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }
    
    // insert Persons info into newSectionArray
    for (ContactModel *model in self.dataArray) {
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(name)];
        [newSectionArray[sectionIndex] addObject:model];
    }
    
    //sort the person of each section
    for (NSUInteger index=0; index<numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(name)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    self.sectionTitlesArray = [NSMutableArray new];
    
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        } else {
            [self.sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [newSectionArray removeObjectsInArray:temp];
    
    NSMutableArray *operrationModels = [NSMutableArray new];
    NSArray *dicts = @[@{@"name" : @"福利机构", @"imageName" : @"plugins_FriendNotify"},
                       @{@"name" : @"备忘录", @"imageName" : @"add_friend_icon_addgroup"},
                       @{@"name" : @"发起群聊", @"imageName" : @"add_friend_icon_offical"}];
    for (NSDictionary *dict in dicts) {
        ContactModel *model = [ContactModel new];
        model.name = dict[@"name"];
        model.imageName = dict[@"imageName"];
        [operrationModels addObject:model];
    }
    
    [newSectionArray insertObject:operrationModels atIndex:0];
    [self.sectionTitlesArray insertObject:@"" atIndex:0];
    
    self.sectionArray = newSectionArray;
    
}

#pragma mark - tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Contacts";
    FriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    ContactModel *model = self.sectionArray[section][row];
    cell.model = model;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitlesArray objectAtIndex:section];
}


- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitlesArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




#pragma mark - UISearchBarDelegate

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    
}


@end
