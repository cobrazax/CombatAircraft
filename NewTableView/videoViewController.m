//
//  videoViewController.m
//  CombatAircraft
//
//  Created by Hackeru on 6/27/13.
//  Copyright (c) 2013 Hackeru. All rights reserved.
//

#import "videoViewController.h"
#import "CombatAircraft.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>

@implementation videoViewController
@synthesize videoWebView,videoURL,navDelegate;

- (void)viewDidLoad
{
    [self startVideo];
}

// Display video

- (void)startVideo
{
    [self.videoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:videoURL]]];
}

// Back button clicked to close the video page

- (IBAction)goBackButtonClicked:(id)sender
{
    if ([navDelegate respondsToSelector:@selector(viewControllerSaidGoBack:)])
    {
        [navDelegate viewControllerSaidGoBack:self];
    }
}

@end
