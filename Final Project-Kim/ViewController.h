//
//  ViewController.h
//  Final Project-Kim
//
//  Created by ETS Admin on 4/2/17.
//  Copyright © 2017 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "plantInfo.h"

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutletCollection(UIButton) NSArray *plantButtons;
@property (nonatomic, retain) IBOutletCollection(UIImageView) NSArray *groundImages;
@property (strong, nonatomic) IBOutlet UICollectionView *groundCollectionView;

@end

