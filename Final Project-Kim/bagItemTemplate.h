//
//  bagItemTemplate.h
//  Final Project-Kim
//
//  Created by ETS Admin on 4/28/17.
//  Copyright © 2017 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "plantInfo.h"
#import "AppDelegate.h"

@interface bagItemTemplate : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView* cropImage;
@property (strong, nonatomic) IBOutlet UIImageView* coinImage;
@property (strong, nonatomic) IBOutlet UILabel* cropName;
@property (strong, nonatomic) IBOutlet UILabel* cropPrice;
@property (strong, nonatomic) IBOutlet UILabel* amount;

-(bagItemTemplate*) init;
@end
