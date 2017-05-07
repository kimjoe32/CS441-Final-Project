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
AppDelegate * appdel;
@implementation StoreViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    appdel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tableDataArray = [[[plantInfo alloc] getAllPlants] copy];
    //load money
    [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appdel.money]];
}


-(NSInteger)    tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return [tableDataArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    plantInfo *pi =[tableDataArray objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", [pi buyPrice]];
    
    [[cell imageView] setImage: [pi getImageForType]];
    cell.textLabel.text = [pi getPlantTypeString];
    
    return cell;
}

- (void)            tableView:(UITableView *)tableView
      didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    plantInfo * pi = [tableDataArray objectAtIndex:indexPath.row];
    NSString * plantName = [pi getPlantTypeString];
    NSString * purchaseString =
                    [NSString stringWithFormat:@"Purchase %@ for %ld",plantName, pi.buyPrice];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:plantName
                                 message:purchaseString
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    if (appdel.money >= pi.buyPrice)
                                    {
                                        appdel.money -= pi.buyPrice;
                                        [self boughtItem:plantName];
                                    }
                                }];
    
    UIAlertAction * cancelButton = [UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    [alert addAction:cancelButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) boughtItem: (NSString*) plantName
{
    [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appdel.money]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification"
                                                        object:plantName];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
