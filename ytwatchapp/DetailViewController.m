//
//  DetailViewController.m
//  ytwatchapp
//
//  Created by Francesco Novelli on 09/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.webView.delegate = self;
        NSString *videoID = [self.detailItem videoID];
        
        [self playVideoID:videoID andName:[self.detailItem title]];
        
  //      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(youTubePlayed:) name:@"AVPlayerItemDidPlayToEndTimeNotification" object:nil];
    }
}

- (void)youTubePlayed:(id)sender {
    self.currentIndex++;
    
    NSString *videoID = [self.videoPlaylist[self.currentIndex] videoID];

    [self playVideoID:videoID andName:[self.videoPlaylist[self.currentIndex] title]];
}


- (void)playVideoID:(NSString *)videoID andName:(NSString *)name {
    NSString *htmlContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iframe" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    
    htmlContent = [htmlContent stringByReplacingOccurrencesOfString:@"[VIDEO_ID]" withString:videoID];

    self.descLabel.text = name;
    
    [self.webView loadHTMLString:htmlContent baseURL:nil];
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
