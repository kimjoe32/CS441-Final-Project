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
    
    for (UIButton * b in _plantButtons)
    {
        //set image of ground patches
        [b.imageView setImage:[UIImage imageNamed:@"dryFloor.png"]];
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
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(checkPlants)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) checkPlants
{
    for (int i = 0; i < 9; i++)
    {
        plantInfo * pi = plantInfoArray[i];
        UIButton * btn = _plantButtons[i];
        UIImageView * groundImg = _groundImages[i];
        
        [pi checkWater];
        if (!pi.isWatered)
        {
            [btn.imageView setImage:[UIImage imageNamed:@"dryfloor.png"]];
        }
        
        groundImg.image = [pi upgrade];
    }
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
    
    [coder encodeObject:bagItems forKey:@"bagItems"];
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
    }
    
    appd.money = [[NSUserDefaults standardUserDefaults] integerForKey:
                 [NSString stringWithFormat:@"money"]];
    
    [coder decodeObjectForKey:@"bagItems"];
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
            [img setImage:nil];
            appd.money += [pi sellPrice];
            
            [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appd.money]];
            [pi killPlant];
        }
    }
    else if (wateringMode) //water the  plant
    {
        [pi water];
        [btn.imageView setImage:[UIImage imageNamed:@"wateredFloor.png"]];
    }
    else if (plantingCount >= 0)
    {
        [pi plantCrop:selectedPlant.plantType];
        plantingCount--;
        for (UICollectionViewCell * cell in [_bagCollectionView visibleCells])
        {
            bagItemCell *b = (bagItemCell*) cell;
            if ([[b.plantInfo getPlantTypeString] isEqualToString:selectedPlant.getPlantTypeString])
            {
                b.amount--;
                if (b.amount <= 0)
                    b.alpha = 0.25f;
                return;
            }
        }
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
        if (b.amount <= 0)
        {
            b.alpha = 0.25f;
        }
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if(![touch.view.restorationIdentifier isEqualToString:@"view1"])
    {
        return;
    }
    wateringMode = FALSE;
    harvestingMode = FALSE;
    [self setPlantInfoPaneToEmpty];
    [_waterButton setEnabled: TRUE];
    [_harvestButton setEnabled: TRUE];
    [_harvestButton setImage:[UIImage imageNamed:@"harvest.png"] forState:UIControlStateNormal];
    [_waterButton setImage:[UIImage imageNamed:@"wateringCan.png"] forState:UIControlStateNormal];
    
    if (!_bagCollectionView.isHidden) _bagCollectionView.hidden = TRUE;
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
    if (cell.amount < 1.0f)
    {
        cell.alpha = 0.25f;
    }
    
    return cell;
}

- (void)    collectionView:(UICollectionView *)collectionView
  didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    bagItemCell * b = (bagItemCell*)[_bagCollectionView cellForItemAtIndexPath:indexPath];
    
    if (b.alpha <= 1.0f) return;
    NSLog(@"picked plant");
    if ([b amount] > 0)
    {
        selectedPlant = b.plantInfo;
        plantingCount = [b amount];
        plantMode = TRUE;
        [_bagCollectionView setHidden:TRUE];
    }
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    NSString *plantName = notification.object;
    [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appd.money]];
    for (UICollectionViewCell * cell in [_bagCollectionView visibleCells])
    {
        bagItemCell *b = (bagItemCell*) cell;
        if ([[b.plantInfo getPlantTypeString] isEqualToString:plantName])
        {
            b.amount++;
            b.alpha = 1.0f;
            return;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
