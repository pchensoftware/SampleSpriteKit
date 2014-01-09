//
//  SpaceshipScene.m
//  SampleSpriteKit
//
//  Created by Peter Chen on 1/9/14.
//  Copyright (c) 2014 Peter Chen. All rights reserved.
//

#import "SpaceshipScene.h"

static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

@interface SpaceshipScene()

@property (nonatomic, assign) BOOL contentCreated;

@end

@implementation SpaceshipScene

- (void)didMoveToView:(SKView *)view {
    if (! self.contentCreated) {
        self.contentCreated = YES;
        [self _createSceneContents];
    }
}

- (void)_createSceneContents {
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    SKSpriteNode *spaceship = [self _newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:spaceship];
    
    SKAction *makeRocks = [SKAction sequence: @[ [SKAction performSelector:@selector(_addRock) onTarget:self],
                                                 [SKAction waitForDuration:0.10 withRange:0.15]]];
    [self runAction:[SKAction repeatActionForever:makeRocks]];
}

- (SKSpriteNode *)_newSpaceship {
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithImageNamed:@"Rocket Ship.png"]; //initWithColor:[SKColor grayColor] size:CGSizeMake(64,32)];
    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    hull.physicsBody.dynamic = NO;
    
    SKAction *hover = [SKAction sequence:@[ [SKAction waitForDuration:1.0],
                                            [SKAction moveByX:100 y:50.0 duration:1.0],
                                            [SKAction waitForDuration:1.0],
                                            [SKAction moveByX:-100.0 y:-50 duration:1.0]]];
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    SKSpriteNode *light1 = [self _newLight];
    light1.position = CGPointMake(-28.0, 6.0);
    [hull addChild:light1];
    
    SKSpriteNode *light2 = [self _newLight];
    light2.position = CGPointMake(28.0, 6.0);
    [hull addChild:light2];
    
    return hull;
}

- (SKSpriteNode *)_newLight {
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(8,8)];
    SKAction *blink = [SKAction sequence:@[ [SKAction fadeOutWithDuration:0.25],
                                            [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [light runAction: blinkForever];
    return light;
}

- (void)_addRock {
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(8,8)];
    rock.position = CGPointMake(skRand(0, self.size.width), self.size.height);
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:rock];
}

- (void)didSimulatePhysics {
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
}

@end
