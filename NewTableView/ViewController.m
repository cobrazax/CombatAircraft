
//
//  ViewController.m
//  NewTableView
//
//  Created by Hackeru on 6/6/13.
//  Copyright (c) 2013 Hackeru. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "CombatAircraft.h"
#import "detailViewController.h"

@implementation UIView (findCell)

// Returning the clicked cell

- (UITableViewCell *) findCell
{
    if ([self isKindOfClass:[UITableViewCell class]])
    {
        return (UITableViewCell *)self;
    }
    
    return [[self superview] findCell];
}

@end

@interface ViewController ()

@end

@implementation ViewController
@synthesize tableArray;

// Opening segue to send data for the custom opening of the detail page

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *cell = nil;
    if ([sender isKindOfClass:[UIView class]])
    {
        cell = [sender findCell];
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    CombatAircraft *caObject = [tableArray objectAtIndex:indexPath.row];
    
    id targetVc = [segue destinationViewController];
    
    if ([targetVc isKindOfClass:[detailViewController class]])
    {
        detailViewController *detailVc = (detailViewController *)targetVc;
        [detailVc setNavDelegate:self];
        [detailVc setCaObject:caObject];
    }
}

// Fetching data using applicasa

- (void)initialize
{         
    [CombatAircraft getArrayWithQuery:nil queryKind:FULL withBlock:^(NSError *error, NSArray *array)
    {
        
        self.tableArray = array;
        
        [self.tableView reloadData];
    }];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self)
    {
        [self initialize];
    }
    return self;
}

// Setting the number of rows for the table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableArray count];
    
}

// Creating the cell for that index using the custom cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell configureWithInfo:[self.tableArray objectAtIndex:indexPath.row]];
        
    return cell;
}

#pragma mark - Navigation Delegate

// Closing the details page as a result of pressing the "back" button

- (void) viewControllerSaidGoBack:(id)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
