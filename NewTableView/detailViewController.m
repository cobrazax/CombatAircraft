//
//  detailViewController.m
//  NewTableView
//
//  Created by Hackeru on 6/6/13.
//  Copyright (c) 2013 Hackeru. All rights reserved.
//

#import "detailViewController.h"
#import "CombatAircraft.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>
#import "videoViewController.h"

@implementation detailViewController
@synthesize caObject,caTitle,caDescription,caImg,caDetails;
@synthesize navDelegate;

// Opening segue to send data for the custom opening of the video page

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id targetVc = [segue destinationViewController];
    
    if ([targetVc isKindOfClass:[videoViewController class]])
    {
        videoViewController *videoVc = (videoViewController *)targetVc;
        [videoVc setNavDelegate:self];
        [videoVc setVideoURL:caObject.combatAircraftVideoURL];
    }
}

- (void)viewDidLoad
{
    // Displaying data
    
    [caTitle setText:[caObject combatAircraftAircraftName]];
    
    [caDescription setText:[caObject combatAircraftDescription]];
    
    NSString *imgStr = caObject.combatAircraftAircraftImage.description;
    NSURL *url = [NSURL URLWithString:imgStr];
    
    [caImg setImageWithURL:url completed:^(UIImage *Image, NSError *error, SDImageCacheType cacheType)
     {
         if(!error)
         {
             caImg.image = Image;
         }
     }];
    
    [caDetails setText:[caObject combatAircraftDetails]];
}

// Back button clicked to close the details page

- (IBAction)goBackButtonClicked:(id)sender
{
    if ([navDelegate respondsToSelector:@selector(viewControllerSaidGoBack:)])
    {
        [navDelegate viewControllerSaidGoBack:self];
    }
}

// Closing the video page as a result of pressing the "back" button

- (void)viewControllerSaidGoBack:(id)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end


