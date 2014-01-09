//
//  MyController.m
//  SampleSpriteKit
//
//  Created by Peter Chen on 1/9/14.
//  Copyright (c) 2014 Peter Chen. All rights reserved.
//
//
// This sample project simply follows the Sprike Kit Programming Guide.
//

#import "MyController.h"
#import <SpriteKit/SpriteKit.h>
#import "HelloScene.h"
#import "SpaceshipScene.h"

@interface MyController ()

@property (nonatomic, strong) SKView *spriteView;
@property (nonatomic, strong) HelloScene *helloScene;

@end

@implementation MyController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SpriteKit";
    
    self.spriteView = [[SKView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    self.spriteView.showsDrawCount = YES;
    self.spriteView.showsNodeCount = YES;
    self.spriteView.showsFPS = YES;
    [self.view addSubview:self.spriteView];
    
    self.helloScene = [[HelloScene alloc] initWithSize:self.spriteView.frame.size];
    [self.spriteView presentScene:self.helloScene];
}

@end
