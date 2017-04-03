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
@implementation ViewController

- (void)viewDidLoad {
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
    
    for (plantInfo * pi in plantInfoArray)
    {
        [pi saveData];
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
    
    for (plantInfo * pi in plantInfoArray)
    {
        [pi loadData];
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
