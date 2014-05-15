//
//  MasterViewController.m
//  ytwatchapp
//
//  Created by Francesco Novelli on 09/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self downloadData];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(downloadData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)downloadData {
    [self.refreshControl beginRefreshing];
    FeedModel *feedModel = [[FeedModel alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable:) name:notificationName object:_objects];
    [feedModel startDownloadItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTable:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        _objects = [sender object];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    });
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    VideoModel *object = _objects[indexPath.row];
    cell.textLabel.text = object.title;

    [cell.imageView setImageWithURL:[NSURL URLWithString:object.imageURL] completed:^(UIImage *image, NSError *err, SDImageCacheType cacheType) {
        loadedImages++;
        [self checkIfRefresh];
    }];
    
    return cell;
}


- (void)checkIfRefresh {

    if(loadedImages <= _objects.count) {
        int i = 0;
        NSMutableArray *indexes = [NSMutableArray array];
        while (i <= loadedImages) {
            [indexes addObject:[NSIndexPath indexPathForItem:i inSection:0]];
            i++;
        }
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *object = _objects[indexPath.row];
    self.detailViewController.detailItem = object;
    self.detailViewController.videoPlaylist = _objects;
    self.detailViewController.currentIndex = indexPath.row;
}

@end
