//
//  ViewController.h
//  NewTableView
//
//  Created by Hackeru on 6/6/13.
//  Copyright (c) 2013 Hackeru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavDelegate.h"

@interface ViewController : UITableViewController <NavDelegate>

@property (nonatomic,strong) NSArray *tableArray;

- (void)initialize;

@end
