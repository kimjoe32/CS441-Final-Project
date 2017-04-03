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

NSMutableArray * groundPatchArray;
@implementation ViewController

- (void)viewDidLoad {
    for (NSInteger i =0; i < [_plantButtons count]; i++)
    {
        groundPatch * gp = [groundPatch alloc];
        gp.isWatered = NO;
        gp.isPlanted = NO;
        gp.lastWatered = nil;
        gp.plantTime = nil;
        gp.location = i + 1;
        [groundPatchArray addObject:gp];
    }
    
    for (UIImageView * img in _groundImages)
    {
        //set image
        img.alpha=0;
    }
    NSLog(@"viewdidload");
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{   //save states
    for (UIButton *b in _plantButtons)
    {
        [coder encodeObject:[b imageForState:UIControlStateNormal] forKey:b.restorationIdentifier];
    }
    
    for (groundPatch * gp in groundPatchArray)
    {
        [gp saveData];
    }
    
    for (UIImageView * img in _groundImages)
    {
        [coder encodeObject:img.image forKey:img.restorationIdentifier];
    }
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{   //restore states
    for (UIButton *b in _plantButtons)
    {
        [b setImage: [coder decodeObjectForKey:b.restorationIdentifier]
           forState:UIControlStateNormal];
    }
    
    for (groundPatch * gp in groundPatchArray)
    {
        [gp loadData];
    }
    
    for (UIImageView * img in _groundImages)
    {
        [img setImage: [coder decodeObjectForKey:img.restorationIdentifier]];
    }
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
