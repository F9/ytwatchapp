//
//  FeedModel.m
//  ytwatchapp
//
//  Created by Francesco Novelli on 09/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import "FeedModel.h"

@implementation FeedModel

- (void)startDownloadItems {
    NSURL *URL = [NSURL URLWithString:feedURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSError *err;
                                      if(!error) {
                                          id itemsArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
                                          
                                          if([itemsArray isKindOfClass:[NSDictionary class]]) {
                                              // self.items = [NSMutableArray arrayWithArray:itemsArray[@"data"][@"items"]];
                                              self.items  = [[NSMutableArray alloc] init];
                                              for (NSDictionary*dic in itemsArray[@"data"][@"items"]) {
                                                  VideoModel *video = [[VideoModel alloc] init];
                                                  video.title = dic[@"title"];
                                                  video.imageURL = dic[@"thumbnail"][@"sqDefault"];
                                                  video.videoID = dic[@"id"];
                                                  
                                                  [self.items addObject:video];
                                              }
                                              
                                              [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self.items];
                                          }
                                        
                                      }
                                  }];
    
    [task resume];
}

@end
