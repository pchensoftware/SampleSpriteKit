//
//  HelloScene.m
//  SampleSpriteKit
//
//  Created by Peter Chen on 1/9/14.
//  Copyright (c) 2014 Peter Chen. All rights reserved.
//

#import "HelloScene.h"
#import "SpaceshipScene.h"

@interface HelloScene()

@property (nonatomic, assign) BOOL contentCreated;

@end

@implementation HelloScene

- (void)didMoveToView:(SKView *)view {
    if (! self.contentCreated) {
        self.contentCreated = YES;
        [self _createSceneContents];
        [self _startAction];
    }
}

- (void)_createSceneContents {
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild:[self _newHelloNode]];
}

- (SKLabelNode *)_newHelloNode {
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text = @"Hello World";
    helloNode.fontSize = 15;
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    helloNode.name = @"helloNode";
    return helloNode;
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self _startAction];
}
*/

- (void)_startAction {
    SKNode *helloNode = [self childNodeWithName:@"helloNode"];
    if (! helloNode)
        return;
    
    helloNode.name = nil;
    SKAction *moveUp = [SKAction moveByX:0 y:10 duration:0.5];
    SKAction *zoom = [SKAction scaleTo:1.5 duration:0.25];
    SKAction *pause = [SKAction waitForDuration:0.5];
    SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *moveSequence = [SKAction sequence:@[moveUp, zoom, pause, fadeAway, remove]];
    [helloNode runAction:moveSequence completion:^{
        SKScene *spaceshipScene  = [[SpaceshipScene alloc] initWithSize:self.size];
        SKTransition *doors = [SKTransition doorwayWithDuration:0.5];
        [self.view presentScene:spaceshipScene transition:doors];
    }];
}

@end
