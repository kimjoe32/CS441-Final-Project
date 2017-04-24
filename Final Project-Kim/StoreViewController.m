//
//  StoreViewController.m
//  Final Project-Kim
//
//  Created by ETS Admin on 4/21/17.
//  Copyright © 2017 Joe. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()
{
    NSArray *tableDataArray;
}
@end

@implementation StoreViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    tableDataArray = [[[plantInfo alloc] getAllPlants] copy];
}


-(NSInteger)    tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return [tableDataArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [[cell imageView] setImage: [[tableDataArray objectAtIndex:indexPath.row] getImageForType]];
    cell.textLabel.text = [[tableDataArray objectAtIndex:indexPath.row] getPlantTypeString];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
