//
//  bagController.h
//  Final Project-Kim
//
//  Created by ETS Admin on 5/4/17.
//  Copyright © 2017 Joe. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "plantInfo.h"
#import "AppDelegate.h"

@interface bagItemCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *itemImageView;
@property (nonatomic, strong) plantInfo * plantInfo;
@property (nonatomic, strong) IBOutlet UILabel * amountLabel;
@property (nonatomic) NSInteger amount;

- (void) setBagItem:(plantInfo *)item;
- (void) updateAmount;
@end




