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
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", [pi sellPrice]];
    
    [[cell imageView] setImage: [pi getImageForType]];
    cell.textLabel.text = [pi getPlantTypeString];
    
    return cell;
}
- (void)            tableView:(UITableView *)tableView
      didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    plantInfo * pi = [tableDataArray objectAtIndex:indexPath.row];
    NSString * plantName = [pi getPlantTypeString];
    NSString * purchaseString = [NSString stringWithFormat:@"Purchase: %@",plantName];
    
    UIAlertController * alertController = [UIAlertController
                                           alertControllerWithTitle: plantName
                                           message: purchaseString
                                           preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Amount";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    [alertController addAction:[UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
                                    NSArray * textfields = alertController.textFields;
                                    UITextField * amountField = textfields[0];
                                    NSInteger amount = [amountField.text integerValue];
                                    if (amount * [pi sellPrice] >= appdel.money)
                                    {
                                        amountField.text = @"";
                                    }
                                    else
                                    {
                                        appdel.money -= amount * [pi sellPrice];
                                        [self boughtItem:plantName amount:amount];
                                    }
                                }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil]];
    
    [self presentViewController:alertController animated:TRUE completion:nil];
}

- (void) boughtItem: (NSString*) plantName
             amount: (NSInteger) amount
{
    // All instances of TestClass will be notified
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification"
                                                        object:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
