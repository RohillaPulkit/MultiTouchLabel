//
//  ViewController.h
//  MultiTouch Label
//
//  Created by Pulkit Rohilla on 04/03/15.
//  Copyright (c) 2015 PulkitRohilla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *multiTouchLabel;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong) UIDynamicAnimator *animator;

@end

