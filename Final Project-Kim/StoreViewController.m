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
    _plantsListTableView.layer.borderColor = [UIColor brownColor].CGColor;
    _plantsListTableView.layer.borderWidth = 2.5f;
}


-(NSInteger)    tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return [tableDataArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //create cells for store items
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    plantInfo *pi =[tableDataArray objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    
    //display image, name, and price
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", [pi buyPrice]];
    
    [[cell imageView] setImage: [pi getImageForType]];
    cell.textLabel.text = [pi getPlantTypeString];
    
    return cell;
}

- (void)            tableView:(UITableView *)tableView
      didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //display alert controller to confirm or cancel purchase of selected crop
    plantInfo * pi = [tableDataArray objectAtIndex:indexPath.row];
    NSString * plantName = [pi getPlantTypeString];
    NSString * purchaseString =
                    [NSString stringWithFormat:@"Purchase %@ for %ld?",plantName, pi.buyPrice];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:plantName
                                 message:purchaseString
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Confirm purchase, send message to main screen
    
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
    
    [alert addAction:yesButton];
    [alert addAction:cancelButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) boughtItem: (NSString*) plantName
{
    //send message to main screen of purchased item
    [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appdel.money]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification"
                                                        object:plantName];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
