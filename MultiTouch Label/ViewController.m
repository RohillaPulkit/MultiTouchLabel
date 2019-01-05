//
//  ViewController.m
//  MultiTouch Label
//
//  Created by Pulkit Rohilla on 04/03/15.
//  Copyright (c) 2015 PulkitRohilla. All rights reserved.
//

#import "ViewController.h"
#import "Range.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat spaceWidth;
    NSMutableArray *wordXPoints;
    NSArray *wordsArray;
    NSString *separator;
    NSMutableArray *arrayOfViews;
}
@synthesize multiTouchLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [multiTouchLabel setUserInteractionEnabled:true];
}

-(void)viewDidAppear:(BOOL)animated{
    
    wordXPoints = [NSMutableArray new];
    
    NSString *string = multiTouchLabel.text;
    separator=@" ";
    [multiTouchLabel setText:string];
    arrayOfViews = [NSMutableArray new];
    
    UIFont *font =[multiTouchLabel font];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGSize stringBoundingBox = [string sizeWithAttributes:attributes];
    
    [multiTouchLabel setFrame:CGRectMake(multiTouchLabel.frame.origin.x, multiTouchLabel.frame.origin.y, stringBoundingBox.width, stringBoundingBox.height)];
    wordsArray = [string componentsSeparatedByString:separator];
    CGSize spaceStringBoundingBox = [separator sizeWithAttributes:attributes];
    spaceWidth=spaceStringBoundingBox.width;
    
    for (NSString *string in wordsArray) {
        
        CGSize stringBoundingBox = [string sizeWithAttributes:attributes];
        
        Range *obj;
        
        if (wordXPoints.count==0) {
            
            CGFloat xPoint=stringBoundingBox.width;
            obj=[[Range alloc]initRangeWithLowerValue:0 andUpperValue:[NSNumber numberWithFloat:xPoint]];
            
        }
        else
        {
            Range *lastObj = [wordXPoints objectAtIndex:wordXPoints.count-1];
            
            CGFloat lowerX = [[lastObj UpperValue] floatValue] + spaceWidth;
            
            CGFloat upperX = lowerX + stringBoundingBox.width;
            
            obj=[[Range alloc] initRangeWithLowerValue:[NSNumber numberWithFloat:lowerX] andUpperValue:[NSNumber numberWithFloat:upperX]];
        }
        
        [wordXPoints addObject:obj];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];

    if ([touch.view isEqual:multiTouchLabel]) {
       
        CGPoint touchLocation = [touch locationInView:touch.view];
        
        BOOL found=false;
        
        NSLog(@"x:%f",touchLocation.x);
        
        for (int index=0;index<wordXPoints.count;index++) {
            
            Range *obj=[wordXPoints objectAtIndex:index];
            
            if (touchLocation.x >= [obj.lowerValue floatValue]&& touchLocation.x <= [obj.UpperValue floatValue]) {
                
                [self.showLabel setText:[wordsArray objectAtIndex:index]];
                
                NSString *txt = [wordsArray objectAtIndex:index];
                txt = [txt stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[txt substringToIndex:1] lowercaseString]];
                NSString *colorName=[NSString stringWithFormat:@"%@Color",txt];
                //[self.backView setBackgroundColor:[UIColor performSelector:NSSelectorFromString(colorName)]];
                
                //[self animateView:self.backView];
                UIView *newView=[self addViewWithColor:colorName];
                [self.view addSubview:newView];
                [self animateView:newView];
                
                NSLog(@"x:%@",[wordsArray objectAtIndex:index]);
                found=true;
                
                break;
            }
        }
        
        if (!found) {
            
            [self.showLabel setText:@""];
        }
    }
}

-(void)animateView:(UIView *)view{
    
    if (view!=nil) {
        
        [arrayOfViews addObject:view];
        
    }
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior* gravityBehavior =
    [[UIGravityBehavior alloc] initWithItems:arrayOfViews];
    [self.animator addBehavior:gravityBehavior];
    
    UICollisionBehavior* collisionBehavior =
    [[UICollisionBehavior alloc] initWithItems:arrayOfViews];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
    
    UIDynamicItemBehavior *elasticityBehavior =
    [[UIDynamicItemBehavior alloc] initWithItems:arrayOfViews];
    elasticityBehavior.elasticity = 0.7f;
    [self.animator addBehavior:elasticityBehavior];
}

-(UIView *)addViewWithColor:(NSString *)color
{
    UIView *view=[UIView new];
    
    NSString *max = [NSString stringWithFormat:@"%f",self.view.frame.size.width-50];
    
    int randX= rand() % ([max intValue]-10)+10;
    
    int randWidth= rand() % (100 - 50)+50;
    
    int dimension=randWidth;
    
    CGRect f = CGRectMake(randX, 10, dimension, dimension);
    
    [view setFrame:f];
//    [view setAlpha:0.5];
    [view.layer setCornerRadius:dimension/2];
    [view setBackgroundColor:[UIColor performSelector:NSSelectorFromString(color)]];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteView:)];
    [view addGestureRecognizer:tap];
    
    return view;
}

-(void)deleteView:(UITapGestureRecognizer *)sender
{
    UIView *view=(UIView *)sender.view;
    
    [view removeFromSuperview];
    [arrayOfViews removeObject:view];
    
    [self animateView:nil];
}


@end
