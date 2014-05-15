//
//  DetailViewController.h
//  ytwatchapp
//
//  Created by Francesco Novelli on 09/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VideoModel.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSMutableArray *videoPlaylist;
@property (nonatomic) int currentIndex;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
