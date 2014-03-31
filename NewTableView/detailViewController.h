//
//  detailViewController.h
//  NewTableView
//
//  Created by Hackeru on 6/6/13.
//  Copyright (c) 2013 Hackeru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CombatAircraft.h"
#import "NavDelegate.h"
@interface detailViewController : UIViewController <NavDelegate>

@property (nonatomic,strong) CombatAircraft *caObject;

@property (weak, nonatomic) IBOutlet UILabel *caTitle;

@property (weak, nonatomic) IBOutlet UILabel *caDescription;

@property (weak, nonatomic) IBOutlet UIImageView *caImg;

@property (weak, nonatomic) IBOutlet UILabel *caDetails;

@property (nonatomic,strong)id <NavDelegate> navDelegate;

@end
