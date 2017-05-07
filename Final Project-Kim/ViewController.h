//
//  ViewController.h
//  Final Project-Kim
//
//  Created by ETS Admin on 4/2/17.
//  Copyright © 2017 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "plantInfo.h"
#import "AppDelegate.h"
#import "bagController.h"

@interface ViewController : UIViewController <UITabBarDelegate,
                                                UICollectionViewDataSource,
                                                UICollectionViewDelegate>

@property (nonatomic, retain) IBOutletCollection(UIButton) NSArray *plantButtons;
@property (nonatomic, retain) IBOutletCollection(UIImageView) NSArray *groundImages;
@property (strong, nonatomic) IBOutlet UIButton *waterButton;
@property (strong, nonatomic) IBOutlet UIButton *harvestButton;
@property (strong, nonatomic) IBOutlet UILabel *cropNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cropSellPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cropTimeRemainingLabel;
@property (nonatomic) plantTypes * plantToSow;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *bagCollectionView;
@property (nonatomic) plantInfo* selectedPlant;
@property (nonatomic) NSInteger plantingCount;

- (IBAction) harvestButton: (id) sender;
- (IBAction) waterButton: (id) sender;
- (IBAction) plantButton: (id) sender;
- (IBAction) tapAnywhereElse:(id)sender;
- (IBAction) backpackButton:(id)sender;

@end

