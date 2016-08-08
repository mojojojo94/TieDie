//
//  ViewController.h
//  TieDie
//
//  Created by Sheheryar Wasti on 5/24/16.
//  Copyright © 2016 orangemangotiger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    IBOutlet UIImageView *friendlyShip;
    IBOutlet UIImageView *enemyShip;
    IBOutlet UIImageView *bullet;
    IBOutlet UIImageView *lifeLostLine;
    
    IBOutlet UILabel *livesLabel;
    IBOutlet UILabel *scoreLabel;
    
    IBOutlet UIButton *startButton;
    
    UITouch *touch;
    
    NSString *livesString;
    NSString *scoreString;
    
    NSTimer *enemyMovementTimer;
    NSTimer *bulletMovementTimer;
    
}

-(IBAction)startGame:(id)sender;

@end

