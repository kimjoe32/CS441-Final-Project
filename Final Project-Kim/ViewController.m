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
    plantInfoArray = [[NSMutableArray alloc] init];
    for (NSInteger i =0; i < [_plantButtons count]; i++)
    {
        plantInfo * pi = [plantInfo alloc];
        pi.isWatered = NO;
        pi.isPlanted = NO;
        pi.lastWatered = 0;
        pi.plantTime = 0;
        pi.location = i + 1;
        [plantInfoArray addObject:pi];
    }
    
    for (UIButton * b in _plantButtons)
    {
        //set image of ground patches
        [b setImage:[UIImage imageNamed:@"dryFloor.png"] forState:UIControlStateNormal];
    }
    
    appd.money = 500;
    [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appd.money]];
    wateringMode = FALSE;
    harvestingMode = FALSE;
    plantMode = FALSE;
    
    bagItems = [[[plantInfo alloc] getAllPlants] copy];
    _bagCollectionView.delegate = self;
    _bagCollectionView.dataSource = self;
    
    [self makeShadowsAndBorders];
    
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

- (void) makeShadowsAndBorders
{
    //shadows for "selected plant" image, wateringcan button, harvestcrop button, and bag
    _displaySelectedPlant.layer.masksToBounds = NO;
    _displaySelectedPlant.layer.shadowOpacity = 0.75f;
    _displaySelectedPlant.layer.shadowRadius = 5.0f;
    _displaySelectedPlant.layer.shadowColor = [UIColor blackColor].CGColor;
    _displaySelectedPlant.layer.shadowPath =
        [UIBezierPath bezierPathWithRoundedRect:_displaySelectedPlant.bounds
                              byRoundingCorners:UIRectCornerAllCorners
                                    cornerRadii:CGSizeMake(0.55, 0.55)].CGPath;
    _displaySelectedPlant.clipsToBounds = NO;
    _displaySelectedPlant.layer.shadowOffset = CGSizeMake(5, 5);
    _displaySelectedPlant.layer.shouldRasterize = YES;
    
    
    _waterButton.layer.masksToBounds = NO;
    _waterButton.layer.shadowOpacity = 0.75f;
    _waterButton.layer.shadowRadius = 5.0f;
    _waterButton.layer.shadowColor = [UIColor blackColor].CGColor;
    
    _waterButton.clipsToBounds = NO;
    _waterButton.layer.shadowOffset = CGSizeMake(5, 5);
    _waterButton.layer.shouldRasterize = YES;
    

    _harvestButton.layer.masksToBounds = NO;
    _harvestButton.layer.shadowOpacity = 0.75f;
    _harvestButton.layer.shadowRadius = 5.0f;
    _harvestButton.layer.shadowColor = [UIColor blackColor].CGColor;
    
    _harvestButton.clipsToBounds = NO;
    _harvestButton.layer.shadowOffset = CGSizeMake(5, 5);
    _harvestButton.layer.shouldRasterize = YES;

    //borders
    _bagCollectionView.layer.borderWidth = 3;
    _bagCollectionView.layer.borderColor = [UIColor brownColor].CGColor;
    
    _displaySelectedPlant.layer.borderWidth = 2.0f;
    _displaySelectedPlant.layer.borderColor = [UIColor brownColor].CGColor;
    _displaySelectedPlant.backgroundColor= [UIColor whiteColor];

    //border which surrounds field (area where crops are placed)
    _fieldBorder.layer.borderWidth= 3.0f;
    _fieldBorder.layer.borderColor = [UIColor brownColor].CGColor;
}

- (void) checkPlants //bad function name
{
    //updates items in main view
    for (int i = 0; i < 9; i++)
    {
        plantInfo * pi = plantInfoArray[i];
        UIButton * btn = _plantButtons[i];
        UIImageView * groundImg = _groundImages[i];
        
        
        //update ground to represent dry floor if it's been a while since watered
        [pi checkWater];
        if (!pi.isWatered)
        {
            [btn setImage:[UIImage imageNamed:@"dryfloor.png"] forState:UIControlStateNormal];
        }
        
        //if the plant reaches next growth stage, update picture
        UIImage* t = [pi upgrade];
        if ( t != nil)
            groundImg.image = t;
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
    //button for when a plant/ground is selected
    NSInteger location = [sender tag] - 1;
    plantInfo * pi = plantInfoArray[location];
    UIButton * btn = _plantButtons[location];
    UIImageView * img = _groundImages[location];
    
    if (harvestingMode) //harvest the plant
    {
        if ([pi canHarvest])
        {
            //harvestable: add to money and clear images
            appd.money += [pi sellPrice];
            [pi harvest];
            [img setImage:nil];
            
            [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appd.money]];
        }
    }
    else if (wateringMode) //water the  plant
    {
        [pi water];
        [btn setImage:[UIImage imageNamed:@"wateredFloor.png"] forState:UIControlStateNormal];
    }
    else if (plantingCount > 0)
    {
        //attempting to plant a crop
        img.image = [pi plantCrop:selectedPlant.plantType];
        
        plantingCount--; // amount of seeds available to plant
        
        for (UICollectionViewCell * cell in [_bagCollectionView visibleCells])
        {
            //find the right corresponding plant in the bag to update total amount of seeds in bag
            bagItemCell *b = (bagItemCell*) cell;
            if ([[b.plantInfo getPlantTypeString] isEqualToString:selectedPlant.getPlantTypeString])
            {
                b.amount--;
                if (b.amount <= 0)
                    b.alpha = 0.25f;
                [b updateAmount];
                return;
            }
        }
        
        if (plantingCount <= 0)
        {
            //no more seeds left: remove selected plant image/selected plant
            _displaySelectedPlant.image = nil;
            selectedPlant = nil;
            plantingCount = 0;
        }
    }
    else
    {
        //get + print plant info
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
    [_cropTimeRemainingLabel setText:[NSString stringWithFormat:@"%.0f", [pi remainingGrowTime]]];
}

- (IBAction) backpackButton: (id)sender
{
    //open backpack. if plants don't have specific seeds, set it to transparent (not available)
    for (UICollectionViewCell * cell in [_bagCollectionView visibleCells])
    {
        bagItemCell *b = (bagItemCell*) cell;
        if (b.amount <= 0)
        {
            b.alpha = 0.25f;
        }
    }
    //reveal bag
    [_bagCollectionView setHidden:FALSE];
}

- (IBAction) waterButton: (id) sender
{
    if (!wateringMode)
    { //enable wateringmode and disable other modes
        [_harvestButton setEnabled: FALSE];
        wateringMode = TRUE;
        harvestingMode = FALSE;
        selectedPlant = nil;
        plantingCount = 0;
        _displaySelectedPlant.image = nil;
        [_waterButton setImage:[UIImage imageNamed:@"wateringInAction.png"] forState:UIControlStateNormal];
    }
    else //turn off watering mode if already selected
    {
        [_waterButton setImage:[UIImage imageNamed:@"wateringCan.png"] forState:UIControlStateNormal];
        [_harvestButton setEnabled: TRUE];
        wateringMode = FALSE;
        harvestingMode = FALSE;
    }
}

- (IBAction) harvestButton: (id) sender
{
    if (!harvestingMode)//enable harvesting mode and disable other modes
    {
        [_waterButton setEnabled: FALSE];
        harvestingMode = TRUE;
        wateringMode = FALSE;
        selectedPlant = nil;
        plantingCount = 0;
        _displaySelectedPlant.image = nil;
        [_harvestButton setImage:[UIImage imageNamed:@"harvestInAction.png"] forState:UIControlStateNormal];
    }
    else //turn off harvesting mode if already selected
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
    
    //touched outside of any buttons, disable everything
    wateringMode = FALSE;
    harvestingMode = FALSE;
    [self setPlantInfoPaneToEmpty];
    [_waterButton setEnabled: TRUE];
    [_harvestButton setEnabled: TRUE];
    [_harvestButton setImage:[UIImage imageNamed:@"harvest.png"] forState:UIControlStateNormal];
    [_waterButton setImage:[UIImage imageNamed:@"wateringCan.png"] forState:UIControlStateNormal];
    selectedPlant = nil;
    _displaySelectedPlant.image = nil;
    plantingCount = 0;
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
    if (cell.amount < 1)
    {   //loaded cell does not have any corresponding seeds diable button (set transparency)
        cell.alpha = 0.25f;
    }
    
    return cell;
}

- (void)    collectionView:(UICollectionView *)collectionView
  didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    bagItemCell * b = (bagItemCell*)[_bagCollectionView cellForItemAtIndexPath:indexPath];
    
    if (b.alpha < 1.0f) return; //if no seeds for seleceted bag item, ignore it
    
    if ([b amount] > 0)
    {
        //selected seed to plant
        //set it as selected plant and exit bag
        selectedPlant = b.plantInfo;
        _displaySelectedPlant.image = [selectedPlant getImageForType];
        plantingCount = [b amount];
        plantMode = TRUE;
        [_bagCollectionView setHidden:TRUE];
    }
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    //received message from store
    //plant is purchased, update bag and money
    NSString *plantName = notification.object;
    [_moneyLabel setText:[NSString stringWithFormat:@"%ld", appd.money]];
    for (UICollectionViewCell * cell in [_bagCollectionView visibleCells])
    {
        bagItemCell *b = (bagItemCell*) cell;
        if ([[b.plantInfo getPlantTypeString] isEqualToString:plantName])
        {
            //find corresponding cell and update it
            b.amount++;
            b.alpha = 1.0f;
            [b updateAmount];
            return;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
