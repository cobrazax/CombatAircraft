//
//  CustomCell.m
//  NewTableView
//
//  Created by Hackeru on 6/6/13.
//  Copyright (c) 2013 Hackeru. All rights reserved.
//

#import "CustomCell.h"
#import "CombatAircraft.h"
#import "UIImageView+WebCache.h"

@implementation CustomCell
@synthesize title,description,image;

// Using data to configure the custom cell

- (void) configureWithInfo:(id)info
{
    // Cell data display
    
    CombatAircraft *combatAircraft = (CombatAircraft *)info;
    [title setText:combatAircraft.combatAircraftAircraftName];
    [description setText:combatAircraft.combatAircraftDescription];
    
    NSString *imgStr = combatAircraft.combatAircraftAircraftImage.description;
    NSURL *url = [NSURL URLWithString:imgStr];
    
    [self.image setImageWithURL:url completed:^(UIImage *Image, NSError *error, SDImageCacheType cacheType)
    {
        if(!error)
        {
            self.image.image = Image;
        }
    }];
}

@end
