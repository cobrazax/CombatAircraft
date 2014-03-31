//
//  CustomCell.h
//  NewTableView
//
//  Created by Hackeru on 6/6/13.
//  Copyright (c) 2013 Hackeru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *description;

@property (weak, nonatomic) IBOutlet UIImageView *image;

- (void) configureWithInfo:(id)info;

@end
