//
//  FeedModel.h
//  ytwatchapp
//
//  Created by Francesco Novelli on 09/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"

#define feedURL @"http://gdata.youtube.com/feeds/api/users/cnn/uploads?v=2&alt=jsonc"
#define notificationName @"downloadEnded"
@interface FeedModel : NSObject

@property (strong) NSMutableArray *items;

- (void)startDownloadItems;

@end
