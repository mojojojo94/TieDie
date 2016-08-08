//
//  ViewController.m
//  TieDie
//
//  Created by Sheheryar Wasti on 5/24/16.
//  Copyright © 2016 orangemangotiger. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

int score;
int lives;
int enemyAttackOccurence;
int enemyPosition;
int randomSpeed;
float speedOfEnemy;

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *friendlyShip1 = [UIImage imageNamed:@"I0_sprite_1.png"];
    UIImage *friendlyShip2 = [UIImage imageNamed:@"I0_sprite_2.png"];
    UIImage *friendlyShip3 = [UIImage imageNamed:@"I0_sprite_3.png"];
    
    self->friendlyShip.animationImages = [[NSArray alloc] initWithObjects:friendlyShip1,friendlyShip2, friendlyShip3, nil];
    self->friendlyShip.animationRepeatCount= 5;
    [self->friendlyShip startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    
    //images to be hidden at start of game
    friendlyShip.hidden = YES;
    enemyShip.hidden = YES;
    bullet.hidden = YES;
    lifeLostLine.hidden = YES;
    
    //labels to be hidden at start of game
    scoreLabel.hidden = YES;
    livesLabel.hidden = YES;
    
    //set score and lives remaining
    score = 0;
    lives = 3;
    
    //strings
    scoreString = [NSString stringWithFormat:@"SCORE: 0"];
    livesString = [NSString stringWithFormat:@"LIVES: 3"];
    
    //Initial label text
    scoreLabel.text = scoreString;
    livesLabel.text = livesString;
    
    //starting postion of images
    friendlyShip.center = CGPointMake(140, 400);
    enemyShip.center = CGPointMake(140, -40);
    bullet.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
    
}

-(IBAction)startGame:(id)sender {
    //hide start button
    startButton.hidden = YES;
    
    //show images
    friendlyShip.hidden = NO;
    enemyShip.hidden = NO;
    lifeLostLine.hidden = NO;
    
    //display labels
    scoreLabel.hidden = NO;
    livesLabel.hidden = NO;
    
    [self positionEnemy];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    friendlyShip.center = CGPointMake(point.x, friendlyShip.center.y);
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [bulletMovementTimer invalidate];
    bullet.hidden = NO;
    bullet.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
    
    bulletMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector (bulletMovement) userInfo:nil repeats:YES];
}

-(void)positionEnemy {
    //random enemy positon
    enemyPosition = arc4random() % 249;
    enemyPosition = enemyPosition + 20;
    
    //set enemy image location
    enemyShip.center = CGPointMake(enemyPosition, -40);
    
    //set enemy speed
    randomSpeed = arc4random() % 3;
    switch (randomSpeed) {
        case 0:
            speedOfEnemy = 0.03;
            break;
        case 1:
            speedOfEnemy = 0.02;
            break;
        case 2:
            speedOfEnemy = 0.01;
            
        default:
            break;
            
    }
    
    enemyAttackOccurence = arc4random() % 5;
    [self performSelector:@selector(enemyMovementTimerMethod) withObject:nil afterDelay:enemyAttackOccurence];
}

-(void)enemyMovementTimerMethod {
    
    enemyMovementTimer = [NSTimer scheduledTimerWithTimeInterval:speedOfEnemy target:self selector:@selector(enemyMovement) userInfo:nil repeats:YES];
    
}

-(void)enemyMovement {
    
    enemyShip.center = CGPointMake(enemyShip.center.x, enemyShip.center.y + 2);
    
    if (CGRectIntersectsRect(enemyShip.frame, lifeLostLine.frame)) {
        lives -= 1;
        livesString = [NSString stringWithFormat:@"LIVES %i", lives];
        livesLabel.text = livesString;
        
        //stop enemy moving
        [enemyMovementTimer invalidate];
        
        if (lives > 0) {
            [self positionEnemy];
        }
        
        if (lives == 0) {
            [self gameOver];
        }
    }
    
}

-(void)bulletMovement {
    
    bullet.hidden = NO;
    bullet.center = CGPointMake(bullet.center.x, bullet.center.y - 2);
    
    if (CGRectIntersectsRect(bullet.frame, enemyShip.frame)) {
        score += 5;
        scoreString = [NSString stringWithFormat:@"SCORE: %i", score];
        scoreLabel.text = scoreString;
        //stop bullet
        [bulletMovementTimer invalidate];
        //position bullet to be central to friendly ship
        bullet.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
        bullet.hidden = YES;
        //stop enemy movement
        [enemyMovementTimer invalidate];
        [self positionEnemy];
        
    }
    
}

-(void)gameOver {
    
    [enemyMovementTimer invalidate];
    [bulletMovementTimer invalidate];
    [self performSelector:@selector(replayGame) withObject:nil afterDelay:3];
    
}

-(void)replayGame {
    
    //images to be hidden at start of game
    friendlyShip.hidden = YES;
    enemyShip.hidden = YES;
    bullet.hidden = YES;
    lifeLostLine.hidden = YES;
    
    //labels to be hidden at start of game
    scoreLabel.hidden = YES;
    livesLabel.hidden = YES;
    
    //set score and lives remaining
    score = 0;
    lives = 3;
    
    //strings
    scoreString = [NSString stringWithFormat:@"SCORE: 0"];
    livesString = [NSString stringWithFormat:@"LIVES: 0"];
    
    //Initial label text
    scoreLabel.text = scoreString;
    livesLabel.text = livesString;
    
    //starting postion of images
    friendlyShip.center = CGPointMake(140, 400);
    enemyShip.center = CGPointMake(140, -40);
    bullet.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
}


@end
