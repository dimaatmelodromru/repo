//
//  FBSKUViewController.m
//  FileBrowser
//
//  Created by Adnan Aftab on 5/4/14.
//  Copyright (c) 2014 coderxperts. All rights reserved.
//

#import "FBSKUViewController.h"


@interface FBSKUViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FBSKUViewController
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.frame = frame;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _skuTags = [FBTag getSkuTag];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 320) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //[_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma Mark - UITableViewDelegate and DataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_skuTags count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (void)configureCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath{
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"WallCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"None";
    }
    else{
        FBTag *tag = [_skuTags objectAtIndex:indexPath.row-1];
        cell.textLabel.text = tag.tagName;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.delegate skuViewController:self didSelectSku:nil];
    }
    else{
        FBTag *tag = [_skuTags objectAtIndex:indexPath.row-1];
        [self.delegate skuViewController:self didSelectSku:tag];
    }
    
}
- (void)viewWillLayoutSubviews{
    self.tableView.frame =self.tableView.superview.superview.frame;
}
@end
