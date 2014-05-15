//
//  MasterViewController.h
//  ytwatchapp
//
//  Created by Francesco Novelli on 09/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FeedModel.h"
#import "VideoModel.h"

#import "UIImageView+WebCache.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController {
    int loadedImages;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
