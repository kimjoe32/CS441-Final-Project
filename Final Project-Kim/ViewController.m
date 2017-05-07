//
//  ViewController.m
//  Final Project-Kim
//
//  Created by ETS Admin on 4/2/17.
//  Copyright © 2017 Joe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray * bagItems;
}
@end

NSMutableArray * plantInfoArray;
BOOL wateringMode;
BOOL harvestingMode;
BOOL plantMode;
AppDelegate * appd;
@implementation ViewController
@synthesize selectedPlant;
@synthesize plantingCount;
- (void)viewDidLoad
{
    appd = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
        //set image of ground patches
        [img setImage:[UIImage imageNamed:@"dryFloor.png"]];
    }
    
    appd.money = 500;
    [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appd.money]];
    wateringMode = FALSE;
    harvestingMode = FALSE;
    plantMode = FALSE;
    
    bagItems = [[[plantInfo alloc] getAllPlants] copy];
    _bagCollectionView.delegate = self;
    _bagCollectionView.dataSource = self;
    _bagCollectionView.layer.borderWidth = 3;
    _bagCollectionView.layer.borderColor = [UIColor brownColor].CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
}


- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{   //save states
    NSLog(@"encoding");
    [super encodeRestorableStateWithCoder:coder];
    
    for (UIButton *b in _plantButtons)
    {
        [coder encodeObject:UIImagePNGRepresentation([b imageForState:UIControlStateNormal])
                     forKey:b.restorationIdentifier];
    }
    
    for (plantInfo * pi in plantInfoArray)
    {
        [pi saveData];
    }
    
    for (UIImageView * img in _groundImages)
    {
        [coder encodeObject:UIImagePNGRepresentation(img.image) forKey:img.restorationIdentifier];
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:appd.money forKey:@"money"];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{   //restore states
    NSLog(@"decoding");
    
    [super decodeRestorableStateWithCoder:coder];
    for (UIButton *b in _plantButtons)
    {
        [b setImage: [UIImage imageWithData:[coder decodeObjectForKey:b.restorationIdentifier]]
           forState:UIControlStateNormal];
    }
    
    for (plantInfo * pi in plantInfoArray)
    {
        [pi loadData];
    }
    
    for (UIImageView * img in _groundImages)
    {
        [img setImage: [UIImage imageWithData:[coder decodeObjectForKey:img.restorationIdentifier]]];
//        NSLog(@"restID =  %@", img.restorationIdentifier);
    }
    
    appd.money = [[NSUserDefaults standardUserDefaults] integerForKey:
                 [NSString stringWithFormat:@"money"]];
    
    [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appd.money]];
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
            appd.money += [pi sellPrice];
            
            [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appd.money]];
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

- (IBAction) backpackButton: (id)sender
{
    for (UICollectionViewCell * cell in [_bagCollectionView visibleCells])
    {
        bagItemCell *b = (bagItemCell*) cell;
        if ([b amount] <= 0) [b setOpaque:TRUE];
    }
    [_bagCollectionView setHidden:FALSE];
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
    
    if (_bagCollectionView.isHidden) _bagCollectionView.hidden = TRUE;
}

- (NSInteger)   collectionView:(UICollectionView *)collectionView
        numberOfItemsInSection:(NSInteger)section
{
    return [bagItems count];
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"bagItemCell1%ld", indexPath.row];
    
    [_bagCollectionView registerClass:[bagItemCell class] forCellWithReuseIdentifier:identifier];
    bagItemCell *cell = [_bagCollectionView
                              dequeueReusableCellWithReuseIdentifier:identifier
                                                        forIndexPath:indexPath];
    [cell setBagItem: [bagItems objectAtIndex:indexPath.row]];
    return cell;
}

- (void)    collectionView:(UICollectionView *)collectionView
  didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    bagItemCell * b = (bagItemCell*) collectionView;
    if ([b isOpaque]) return;
    
    if ([b amount] > 0)
    {
        bagItemCell * cell = (bagItemCell*)[_bagCollectionView cellForItemAtIndexPath:indexPath];
        selectedPlant = cell.plantInfo;
        plantingCount = [b amount];
        plantMode = TRUE;
        [_bagCollectionView setHidden:TRUE];
    }
}


- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"TestNotification"])
        NSLog (@"Successfully received the test notification!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
