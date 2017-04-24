//
//  ViewController.m
//  Final Project-Kim
//
//  Created by ETS Admin on 4/2/17.
//  Copyright © 2017 Joe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

NSMutableArray * plantInfoArray;
BOOL wateringMode;
BOOL harvestingMode;
NSInteger  money;
@implementation ViewController

+(UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    UIViewController * myViewController =
    [[ViewController alloc]
     initWithNibName:@"view"
     bundle:nil];
    
    return myViewController;
}

- (void) viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");
    [super viewWillDisappear:animated];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    NSLog(@"viewdidload");
    for (NSInteger i =0; i < [_plantButtons count]; i++)
    {
        plantInfo * pi = [plantInfo alloc];
        pi.isWatered = NO;
        pi.isPlanted = NO;
        pi.lastWatered = nil;
        pi.plantTime = nil;
        pi.location = i + 1;
        [plantInfoArray addObject:pi];
    }
    
    for (UIImageView * img in _groundImages)
    {
        //set image
        [img setImage:[UIImage imageNamed:@"dryFloor.png"]];
    }
    
    money = 500;
    wateringMode = FALSE;
    harvestingMode = FALSE;
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{   //save states
    NSLog(@"encoding");
    
    for (UIButton *b in _plantButtons)
    {
        [coder encodeObject:[b imageForState:UIControlStateNormal] forKey:b.restorationIdentifier];
    }
    
    for (plantInfo * pi in plantInfoArray)
    {
        [pi saveData];
    }
    
    for (UIImageView * img in _groundImages)
    {
        [coder encodeObject:img.image forKey:img.restorationIdentifier];
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:money forKey:@"money"];
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{   //restore states
    NSLog(@"decoding");
    for (UIButton *b in _plantButtons)
    {
        [b setImage: [coder decodeObjectForKey:b.restorationIdentifier]
           forState:UIControlStateNormal];
    }
    
    for (plantInfo * pi in plantInfoArray)
    {
        [pi loadData];
    }
    
    for (UIImageView * img in _groundImages)
    {
        [img setImage: [coder decodeObjectForKey:img.restorationIdentifier]];
    }
    
    money = [[NSUserDefaults standardUserDefaults] integerForKey:
                 [NSString stringWithFormat:@"money"]];
    
    [super decodeRestorableStateWithCoder:coder];
}

- (IBAction) plantButton: (id) sender
{
    NSInteger location = [sender tag];
    plantInfo * pi = plantInfoArray[location - 1];
    UIButton * btn = _plantButtons[location - 1];
    UIImageView * img = _groundImages[location - 1];
    if (harvestingMode) //harvest the plant
    {
        if ([pi canHarvest])
        {
            [pi harvest];
            [btn setImage:nil forState:UIControlStateNormal];
            money += [pi sellPrice];
            [pi killPlant];
        }
    }
    else if (wateringMode) //water the plant
    {
        [pi water];
        [img setImage:[UIImage imageNamed:@"wateredFloor.png"]];
    }
    else
    {   //get + print plant info
        plantInfo * pi =[plantInfoArray objectAtIndex:location];
        if ( ![pi isPlanted])
        {   //nothing is planted
            [self setPlantInfoPaneToEmpty];
        }
        else
        {
            [self setPlantInfoPane:pi];
        }
    }
}

- (void) setPlantInfoPaneToEmpty
{
    [_cropNameLabel setText:@"N/A"];
    [_cropSellPriceLabel setText:@"0"];
    [_cropTimeRemainingLabel setText:@"0"];
}

- (void) setPlantInfoPane: (plantInfo*) pi
{
    [_cropNameLabel setText:[pi getPlantTypeString]];
    [_cropSellPriceLabel setText:[NSString stringWithFormat:@"%ld", [pi sellPrice]]];
    [_cropTimeRemainingLabel setText:[NSString stringWithFormat:@"%f", [pi remainingGrowTime]]];
}

- (IBAction) waterButton: (id) sender
{
    if (!wateringMode)
    { //enable wateringmode
        [_harvestButton setEnabled: FALSE];
        wateringMode = TRUE;
        harvestingMode = FALSE;
        [_waterButton setImage:[UIImage imageNamed:@"wateringInAction.png"] forState:UIControlStateNormal];
    }
    else //turn off watering mode
    {
        [_waterButton setImage:[UIImage imageNamed:@"wateringCan.png"] forState:UIControlStateNormal];
        [_harvestButton setEnabled: TRUE];
        wateringMode = FALSE;
        harvestingMode = FALSE;
    }
    
}

- (IBAction) harvestButton: (id) sender
{
    if (!harvestingMode)//enable harvesting mode
    {
        [_waterButton setEnabled: FALSE];
        harvestingMode = TRUE;
        wateringMode = FALSE;
        [_harvestButton setImage:[UIImage imageNamed:@"harvestInAction.png"] forState:UIControlStateNormal];
    }
    else //turn off harvesting mode
    {
        [_harvestButton setImage:[UIImage imageNamed:@"harvest.png"] forState:UIControlStateNormal];
        [_waterButton setEnabled: TRUE];
        harvestingMode = FALSE;
        wateringMode = FALSE;
    }
}

- (IBAction) tapAnywhereElse:(id)sender
{
    wateringMode = FALSE;
    harvestingMode = FALSE;
    [self setPlantInfoPaneToEmpty];
    [_waterButton setEnabled: TRUE];
    [_harvestButton setEnabled: TRUE];
    [_harvestButton setImage:[UIImage imageNamed:@"harvest.png"] forState:UIControlStateNormal];
    [_waterButton setImage:[UIImage imageNamed:@"wateringCan.png"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
