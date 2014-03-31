//
//  videoViewController.h
//  CombatAircraft
//
//  Created by Hackeru on 6/27/13.
//  Copyright (c) 2013 Hackeru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavDelegate.h"

@interface videoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *videoWebView;

@property (nonatomic,strong) id <NavDelegate> navDelegate;

@property (nonatomic,strong) NSString *videoURL;

@end
